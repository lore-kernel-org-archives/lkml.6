Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3672311-1525410059-2-16589381694105031363
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='name', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525410059; b=kdPnxW6wv5xLb2PjWvEFju3VaqmLXrNG0r22b1iGmy1KFlxgkg
    Di77btnuSBWPb/+KnindCVyKpE3x9GUNW87cezAIul4HWxWpHUyA3AMbhrlqE1Rf
    f8fLrGgZMOLNHLOEmMbKHccclkKMl8zsH0XpTW8IUMw4LBTQA2oaH6DpngUEMAnR
    eoYSJ8CMCqIorZBzXyPDn9egUstpaxW1NV5v+3y3SIYlH0+k5Dw5/NbKyBIjae6L
    XJAJjkDQUwOazH3j0fOzdMcJ6CmD0CQRgoW92/P5IQ5zr6hznkuaHqdKSz9jaMMJ
    h4ElaIevaBINc+BkbRXXdaZ6Sf3j779fSNVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525410059; bh=alp9m
    KCYDWiNU9cnG7ngMu0K0j8r5hlNEPuMrFNJCtY=; b=DiZp6qmB8T/QVr9wD0GVH
    Wo31Q7w5Khi+eLfZJ47ui5G40Ak8vJwERE0le+jgxmVNfOmRGC6NJKc+xefw2yfl
    7ySe70yrzGaQT0MRbyEJW0qsDbtoBgYL4XDgMBknQgXYfzK91CKma84FZYSosfzb
    KavDvXLoKtvDDv611TtRWF7QRUBL0UuzDSkS2o84oDaRuaImaqqzZcU1xon/w11e
    Eg22F+WQQD7YkBzAiSvT3uSgx8HFa71ObKQYKuDKhL2h0xgaVsKOolvNrmb6XjhC
    PnwjgVI8S+yY6gerIzA5XnGMRtpt/T0z54CIFQHqKvzGChtXyQr80i+TgWYbAdLp
    A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=brown.name;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=brown.name header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=brown.name;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=brown.name header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDor9URSIxOUqMHV6JB/WiTisnb6p1MTmH79AHfteFfyXs9bu5iu4yG5qn5cCXT9l+FeV0eWrrxDyDP7c4XBCz9Wa2Y/gt7wlNM74p7ttvCQRS1wVqCG
    i/Fw2mWOrS5X1WO+e21GmEF6CB9LkdyXUq1fSCZBjyMeObYrMOIm7LMPES8picXlT28SkS6AAy8tw8eUPzuVpax+Ex3TTIvnr5zzZGmC/aA7Ayt+uZR1efMv
    CqdbinhqDD2Kbaf5aVBKzQ==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=MKtGQD3n3ToA:10
    a=VUJBJC2UJ8kA:10 a=qEKT6kP3PEYA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=ZZnuYtJkoWoA:10 a=DDOyTI_5AAAA:8 a=go3m4GvL071v4VyiW80A:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: NeilBrown <neil@brown.name>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 04 May 2018 14:58:35 +1000
Subject: [PATCH 1/8] staging: mt7621-eth: Lock is never unlocked.
Message-ID: <152540991585.12190.1091705512182182698.stgit@noble>
In-Reply-To: <152540982998.12190.15220622955317261586.stgit@noble>
References: <152540982998.12190.15220622955317261586.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

mtk_phy_link_adjust takes a spinlock and disables
interrupts, but never unlocks.
This can leave interrupts disabled on one CPU and
various things stop working.

Signed-off-by: NeilBrown <neil@brown.name>
---
 drivers/staging/mt7621-eth/mdio.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/mt7621-eth/mdio.c b/drivers/staging/mt7621-eth/mdio.c
index 9d713078ef90..c6db11aad9e4 100644
--- a/drivers/staging/mt7621-eth/mdio.c
+++ b/drivers/staging/mt7621-eth/mdio.c
@@ -57,6 +57,7 @@ static void mtk_phy_link_adjust(struct net_device *dev)
 			}
 		}
 	}
+	spin_unlock_irqrestore(&eth->phy->lock, flags);
 }
 
 int mtk_connect_phy_node(struct mtk_eth *eth, struct mtk_mac *mac,


_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
