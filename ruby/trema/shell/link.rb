#
# link command of Trema shell.
#
# Author: Yasuhito Takamiya <yasuhito@gmail.com>
#
# Copyright (C) 2008-2011 NEC Corporation
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License, version 2, as
# published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#


require "trema/dsl"


module Trema
  module Shell
    def link peer0, peer1
      stanza = DSL::Link.new( peer0, peer1 )
      link = Link.new( stanza )
      link.enable!

      if Switch[ peer0 ]
        Switch[ peer0 ].add_interface link.name
      end
      if Switch[ peer1 ]
        Switch[ peer1 ].add_interface link.name_peer
      end

      if Host[ peer0 ]
        Host[ peer0 ].interface = link.name
        Host[ peer0 ].run!
      end
      if Host[ peer1 ]
        Host[ peer1 ].interface = link.name_peer
        Host[ peer1 ].run!
      end

      true
    end
  end
end


### Local variables:
### mode: Ruby
### coding: utf-8
### indent-tabs-mode: nil
### End: