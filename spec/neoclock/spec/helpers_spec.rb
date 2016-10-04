#module Neoclock
#  describe 'blender' do
#    context 'blend colours' do
#      test_cases = {
#        [[255, 0, 0], [0, 0, 255]] => {
#          15 => [191, 0, 63],
#          30 => [127, 0, 127]
#        },
#        [[127, 0, 127], [0, 127, 255]] => {
#          0  => [127, 0, 127],
#          30 => [63, 63, 191],
#          20 => [84, 42, 169],
#          45 => [31, 95, 223]
#        }
#      }
#
#      test_cases.each_pair do |colours, expectations|
#        context "with #{colours}" do
#          expectations.each_pair do |sixtieth, colour|
#            it "makes #{colour} for #{sixtieth} / 30" do
#              expect(
#                Neoclock.blender *colours, sixtieth
#              ).to eq colour
#            end
#          end
#        end
#      end
#    end
#
#    context 'intersperse' do
#      it 'solves a simple case' do
#        expect(Neoclock.intersperse 255, 0, 30).to eq 127
#      end
#
#      it 'solves an inverse case' do
#        expect(Neoclock.intersperse 0, 255, 15).to eq 63
#      end
#
#      it 'does not care if we start from 0' do
#        expect(Neoclock.intersperse 127, 255, 30).to eq 191
#      end
#
#      it 'is fine coming from the other direction' do
#        expect(Neoclock.intersperse 255, 0, 15).to eq 191
#      end
#    end
#  end
#end
