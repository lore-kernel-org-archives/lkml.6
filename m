Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939503AbeE1O7o (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:59:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:45522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034127AbeE1K0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:26:10 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Robinson <pbrobinson@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 252/268] crypto: sunxi-ss - Add MODULE_ALIAS to sun4i-ss
Date: Mon, 28 May 2018 12:03:46 +0200
Message-Id: <20180528100231.738824774@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Robinson <pbrobinson@gmail.com>

[ Upstream commit 7c73cf4cc2ac16465f5102437dc0a12d66671bd6 ]

The MODULE_ALIAS is required to enable the sun4i-ss driver to load
automatically when built at a module. Tested on a Cubietruck.

Fixes: 6298e948215f ("crypto: sunxi-ss - Add Allwinner Security System crypto accelerator")
Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/sunxi-ss/sun4i-ss-core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/crypto/sunxi-ss/sun4i-ss-core.c
+++ b/drivers/crypto/sunxi-ss/sun4i-ss-core.c
@@ -422,6 +422,7 @@ static struct platform_driver sun4i_ss_d
 
 module_platform_driver(sun4i_ss_driver);
 
+MODULE_ALIAS("platform:sun4i-ss");
 MODULE_DESCRIPTION("Allwinner Security System cryptographic accelerator");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Corentin LABBE <clabbe.montjoie@gmail.com>");
