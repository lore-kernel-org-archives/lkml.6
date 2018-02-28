Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751996AbeB1AQ6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 19:16:58 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:24515 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751654AbeB1AQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 19:16:55 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w1S0Fahk000353
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Marc Herbert <marc.herbert@intel.com>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org, Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH v2 0/6] kconfig: some clean-ups and rename silentoldconfig
Date: Wed, 28 Feb 2018 09:15:20 +0900
Message-Id: <1519776926-30459-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada (6):
  kconfig: do not call check_conf() for olddefconfig
  kconfig: remove unneeded input_mode test in conf()
  kconfig: remove redundant input_mode test for check_conf() loop
  kconfig: hide irrelevant sub-menus for oldconfig
  kconfig: invoke oldconfig instead of silentoldconfig from local*config
  kconfig: rename silentoldconfig to syncconfig

 Documentation/kbuild/kconfig.txt |  2 +-
 Makefile                         |  2 +-
 scripts/kconfig/Makefile         |  8 ++++----
 scripts/kconfig/conf.c           | 41 ++++++++++++++++++++--------------------
 4 files changed, 27 insertions(+), 26 deletions(-)

-- 
2.7.4
