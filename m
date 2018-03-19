Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3490082-1521484957-2-4026231133643346141
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES encaro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521484955; b=nYL77qEg4gGLwsQvXAo0jSWbRuijbYebHA9A36xWy3LrUOF
    GfYupc7LMCUukbwA4SvfBGrPh+eIElMphbZG1eTIukVJ2Kdw9KLcf+QhHBuevV0S
    gZsI0DZANy4beRs/kCQAje1avrn1KWAPGxnjA7hUE6jKDIZCNHVqJvFvalKfPxJ6
    WerCSYqjfOJE+v1zdV9l/a6hGjKM08Je4mGViSIpWKnvkh5yrv9gGLHXNSOOeS9T
    VaNAP3Yx+fwh89RruLARXBIo5DewnzGsLWduxz6BpcLpZBcN+ooe1fGfkD3TsvAP
    vanXJ8uto2zE8qHyhG8AcQr8/ESfSDQIMSVUtJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521484955; bh=03mY+PY0cjPvTqrjO8Fo8hV1oP
    KA86BSxQdl9NqBpi4=; b=H7niXo/ge8AJZVzLmIQTMJ+bFh2/r8SvkLhz90U4J+
    Te3gXmcO5wECMn8jpo+8zZtWy/GANKn9h2waVJ9znD6giUlZMe8+9k7VEpUqES4Y
    mx3eFU2EVaL8fYmipttPUY62CPWlL8DWDOvEyp7W8LW9IRFkn0mN/oIPCzPepNpr
    iorWEpdFTx+fWj8FGV9P33ELBW2KUAlUdKPgyD3yLQzRodae+HgyqTYHwqt1PSWI
    30KevE+Hc3CrKJizTWiTBaBKKqUWNZQ6/G2Oo8X1zRyuY3b93p64S3+/7QFPorSK
    DS7g9T2jgAtTIbmfw4AfjwIlqUyO4PNez3cORbbkRmww==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpledtrdelvddriedurddvtddvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepfedtfeeinecuvehluhhsthgvrhfuihiivgepie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpledtrdelvddriedurddvtddvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepfedtfeeinecuvehluhhsthgvrhfuihiivgepie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966430AbeCSSmS (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:42:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54024 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S970317AbeCSSci (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:32:38 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amelie Delaunay <amelie.delaunay@st.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.15 42/52] usb: dwc2: fix STM32F7 USB OTG HS compatible
Date: Mon, 19 Mar 2018 19:08:40 +0100
Message-Id: <20180319180737.324794612@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180734.976730813@linuxfoundation.org>
References: <20180319180734.976730813@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amelie Delaunay <amelie.delaunay@st.com>

commit 1a149e3554e0324a3d551dfb327bdb67b150a320 upstream.

This patch fixes compatible for STM32F7 USB OTG HS and consistently rename
dw2_set_params function.
The v2 former patch [1] had been acked by Paul Young, but v1 was merged.

[1] https://patchwork.kernel.org/patch/9925573/

Fixes: d8fae8b93682 ("usb: dwc2: add support for STM32F7xx USB OTG HS")
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/dwc2/params.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -137,7 +137,7 @@ static void dwc2_set_stm32f4x9_fsotg_par
 	p->activate_stm_fs_transceiver = true;
 }
 
-static void dwc2_set_stm32f7xx_hsotg_params(struct dwc2_hsotg *hsotg)
+static void dwc2_set_stm32f7_hsotg_params(struct dwc2_hsotg *hsotg)
 {
 	struct dwc2_core_params *p = &hsotg->params;
 
@@ -164,8 +164,8 @@ const struct of_device_id dwc2_of_match_
 	{ .compatible = "st,stm32f4x9-fsotg",
 	  .data = dwc2_set_stm32f4x9_fsotg_params },
 	{ .compatible = "st,stm32f4x9-hsotg" },
-	{ .compatible = "st,stm32f7xx-hsotg",
-	  .data = dwc2_set_stm32f7xx_hsotg_params },
+	{ .compatible = "st,stm32f7-hsotg",
+	  .data = dwc2_set_stm32f7_hsotg_params },
 	{},
 };
 MODULE_DEVICE_TABLE(of, dwc2_of_match_table);
