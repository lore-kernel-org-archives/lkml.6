Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1757396-1527158363-2-11236347723583248061
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enroda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527158362; b=ayO8rnk5NHr6CfJKfUUUYkazvfwUjw5n/XwYLVVLjbX3LrNBtI
    sXuBBjuvi15AcPPDDERVrmQ6T9qaNDaw1ZdxN44g7AEBgCFJT3fPcvsjzVGnEB2y
    wgdH87PH//r8ZAQDGbrgOeuocTOnh/VaAs+/1Wg5bckMuJVUunfUYw+3Jjsh1o0O
    A8hUa1zu6C6vWsITAg6+9aw9vRjo4EBVQjsKmXvsr+egOp/CWuw/O9m/BBJweipa
    9EgV6HYfxh1kBQxrw4Q924Wqd0suVkOUwmeERzaZMnPwX6gOgmIMDKIR5moLJakw
    UUe7iKtwJYUmb6HrlcL9FyUoAoPO/D1XKB5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527158362; bh=cxOpGOv09RLngUqSqrS+zltCBkg24+
    TamwgfmSRi9+c=; b=Icjow722TyTHNNr+LQY8TnXxFKO4JRC0AcXwlDdvX699gg
    jlhljXrmgk+s9blxeBYChWOT3ry/H+9+nrGUCkNjVAXFKcBmODNcIEYCZz9cCcaS
    wjmikx+1F+y2c70tBhfdcYBprzmYfVcnG/q+vio2x3vtyxdWglGsLynRtKK9QHmU
    R2o0wQXLLckXRgyZcnfeJqJIgxaYUlPqO4EvF3eSzw5OwNc+WXZv0KydXRv/kvCE
    w5suYXuMXq5SPfaQjWU7NypcK+a4BxGqBmfI2NebU78ssYOkWi+vSjBXMD4HjMA6
    DQOO38ldivd+GGYv9iHJxftop+f22MH9oYkoms0g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=XXlKQTHB x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=XXlKQTHB x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFvISrHlFlmi7J4yAuIYEdD8HWLDu5x+Dn5YFPeXQiG8YFfHzTtlmzGUHH5yAqz9u5htc+3cmbNrzW257E1tvI5EFadk6rq2af+OSo4dSAlZRlLLfr8K
    8GX7rxcTTh/srysRKtc9ycqn4uvXrnuJnEJoy/386jaObm0kGIO7LV2Ch+JoICnciTr6O2ZzfxkOZlajyiC9NIitp3Lb7ufjIf+6LrMB/hcQzVnO+QCmfSPl
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=tPNqkz7QXGkNkY1_-T4A:9
    a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030520AbeEXKjF (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:39:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:40268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030753AbeEXJ7X (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:59:23 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 015/161] net: dsa: Do not register devlink for unused ports
Date: Thu, 24 May 2018 11:37:20 +0200
Message-Id: <20180524093020.211729785@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 5447d78623da2eded06d4cd9469d1a71eba43bc4 ]

Even if commit 1d27732f411d ("net: dsa: setup and teardown ports") indicated
that registering a devlink instance for unused ports is not a problem, and this
is true, this can be confusing nonetheless, so let's not do it.

Fixes: 1d27732f411d ("net: dsa: setup and teardown ports")
Reported-by: Jiri Pirko <jiri@resnulli.us>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/dsa/dsa2.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/net/dsa/dsa2.c
+++ b/net/dsa/dsa2.c
@@ -258,11 +258,13 @@ static void dsa_tree_teardown_default_cp
 static int dsa_port_setup(struct dsa_port *dp)
 {
 	struct dsa_switch *ds = dp->ds;
-	int err;
+	int err = 0;
 
 	memset(&dp->devlink_port, 0, sizeof(dp->devlink_port));
 
-	err = devlink_port_register(ds->devlink, &dp->devlink_port, dp->index);
+	if (dp->type != DSA_PORT_TYPE_UNUSED)
+		err = devlink_port_register(ds->devlink, &dp->devlink_port,
+					    dp->index);
 	if (err)
 		return err;
 
@@ -293,7 +295,8 @@ static int dsa_port_setup(struct dsa_por
 
 static void dsa_port_teardown(struct dsa_port *dp)
 {
-	devlink_port_unregister(&dp->devlink_port);
+	if (dp->type != DSA_PORT_TYPE_UNUSED)
+		devlink_port_unregister(&dp->devlink_port);
 
 	switch (dp->type) {
 	case DSA_PORT_TYPE_UNUSED:
