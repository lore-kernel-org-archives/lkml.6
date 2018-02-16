Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032471AbeBPNsf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 08:48:35 -0500
Received: from osg.samsung.com ([64.30.133.232]:39685 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032355AbeBPNsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 08:48:31 -0500
From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jani Nikula <jani.nikula@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Tom Saeger <tom.saeger@oracle.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        intel-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, dri-devel@lists.freedesktop.org
Subject: [PATCH 0/6] Add support for in-line nested struct comments
Date: Fri, 16 Feb 2018 11:48:14 -0200
Message-Id: <cover.1518788761.git.mchehab@s-opensource.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fix two bugs at kernel-doc.rst examples and add support
for in-line nested struct comments.

It also converts one documentation at intel_dpio_phy to use it,
in order to give a practical example about how to use it.

Mauro Carvalho Chehab (6):
  doc-guide: kernel-doc: fix example for nested_foobar struct
  doc-guide: kernel-doc: fix example for inlined comments
  doc-guide: kernel-doc: move in-line section to be after nested struct
  scripts: kernel-doc: support in-line comments on nested structs/unions
  doc-guide: kernel-doc: add examples about nested union/structs
  drm: intel_dpio_phy: fix kernel-doc comments at nested struct

 Documentation/doc-guide/kernel-doc.rst | 69 ++++++++++++++++++++--------------
 drivers/gpu/drm/i915/intel_dpio_phy.c  |  2 +-
 scripts/kernel-doc                     |  2 +-
 3 files changed, 43 insertions(+), 30 deletions(-)

-- 
2.14.3
