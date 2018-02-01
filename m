Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752027AbeBAJu2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 04:50:28 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:46053
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751522AbeBAJu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 04:50:27 -0500
X-IronPort-AV: E=Sophos;i="5.46,443,1511823600";
   d="scan'208";a="253235017"
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: kernel-janitors@vger.kernel.org, Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Coccinelle: coccicheck: fix typo
Date: Thu,  1 Feb 2018 10:20:55 +0100
Message-Id: <1517476855-5235-1-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct spelling of "coccinelle".

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 scripts/coccicheck |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index ecfac64..9fedca6 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -177,7 +177,7 @@ coccinelle () {
     REQ_NUM=$(echo $REQ | ${DIR}/scripts/ld-version.sh)
     if [ "$REQ_NUM" != "0" ] ; then
 	    if [ "$SPATCH_VERSION_NUM" -lt "$REQ_NUM" ] ; then
-		    echo "Skipping coccinele SmPL patch: $COCCI"
+		    echo "Skipping coccinelle SmPL patch: $COCCI"
 		    echo "You have coccinelle:           $SPATCH_VERSION"
 		    echo "This SmPL patch requires:      $REQ"
 		    return
