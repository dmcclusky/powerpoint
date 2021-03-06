require 'zip/filesystem'
require 'fileutils'

module Powerpoint
  module Slide
    class Powerpoint::Slide::Pictorial
      def initialize extract_path, image_path, slide_number, coords={}
      	
      	image_name = File.basename(image_path)
      	FileUtils.copy_file(image_path, "#{extract_path}/ppt/media/#{image_name}")

      	coords_tag = (coords.empty?) ? '' : '<p:spPr>
									            <a:xfrm>
									                <a:off x="' + coords[:x].to_s + '" y="' + coords[:y].to_s + '" />
									                <a:ext cx="' + coords[:cx].to_s + '" cy="' + coords[:cy].to_s + '" />
									            </a:xfrm>
									        </p:spPr>'

        rel_xml =  '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
					<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
					    <Relationship Id="rId2" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/image" Target="../media/' + image_name + '" />
					    <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideLayout" Target="../slideLayouts/slideLayout2.xml" />
					</Relationships>'

        rel_path = "#{extract_path}/ppt/slides/_rels/slide#{slide_number}.xml.rels"
        File.open(rel_path, 'w'){ |f| f << rel_xml }

		slide_xml =  '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
					<p:sld xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:p="http://schemas.openxmlformats.org/presentationml/2006/main">
					    <p:cSld>
					        <p:spTree>
					            <p:nvGrpSpPr>
					                <p:cNvPr id="1" name="" />
					                <p:cNvGrpSpPr />
					                <p:nvPr />
					            </p:nvGrpSpPr>
					            <p:grpSpPr>
					                <a:xfrm>
					                    <a:off x="0" y="0" />
					                    <a:ext cx="0" cy="0" />
					                    <a:chOff x="0" y="0" />
					                    <a:chExt cx="0" cy="0" />
					                </a:xfrm>
					            </p:grpSpPr>
					            <p:pic>
					                <p:nvPicPr>
					                    <p:cNvPr id="4" name="Content Placeholder 3" />
					                    <p:cNvPicPr>
					                        <a:picLocks noGrp="1" noChangeAspect="1" />
					                    </p:cNvPicPr>
					                    <p:nvPr>
					                        <p:ph idx="1" />
					                    </p:nvPr>
					                </p:nvPicPr>
					                <p:blipFill>
					                    <a:blip r:embed="rId2">
					                        <a:extLst>
					                            <a:ext uri="{28A0092B-C50C-407E-A947-70E740481C1C}">
					                                <a14:useLocalDpi xmlns:a14="http://schemas.microsoft.com/office/drawing/2010/main" val="0" />
					                            </a:ext>
					                        </a:extLst>
					                    </a:blip>
					                    <a:stretch>
					                        <a:fillRect />
					                    </a:stretch>
					                </p:blipFill>' + coords_tag +
					            '</p:pic>
					        </p:spTree>
					        <p:extLst>
					            <p:ext uri="{BB962C8B-B14F-4D97-AF65-F5344CB8AC3E}">
					                <p14:creationId xmlns:p14="http://schemas.microsoft.com/office/powerpoint/2010/main" val="1474098577" />
					            </p:ext>
					        </p:extLst>
					    </p:cSld>
					    <p:clrMapOvr>
					        <a:masterClrMapping />
					    </p:clrMapOvr>
					</p:sld>'

        slide_path = "#{extract_path}/ppt/slides/slide#{slide_number}.xml"
        File.open(slide_path, 'w'){ |f| f << slide_xml }        
      end
    end
  end
end