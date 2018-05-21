Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1344077-1526937916-2-15537556695686516813
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526937916; b=NCEn2Ul6kQ7SYA6RtuqD1Z7zQdq2sC5IdDET2zZIXEMPZX8Q3J
    /OHq+M6ITJ0vT2vjN/qfII6tZMTz6nuRZ0DL43nCT4f8PHx8kH2bFpeYKglA8yz/
    pEe1b0O/DAw80lrMnxHevlYp51fWYxHZHGrIahcAiWYTAlw7qfa+3eouu/J2Fd8M
    wsmMQ8usKGc91N2alIwr7HmA0hvj6iJOVg12y2s2d/cSnP0hw9U+nnYmq4SU9ZIp
    7qsfnOfvt0kOmxpQKnjynrz89wix4dkX4mklqVvMy0V2b0KiHjnsFLm5qJ0YAgZ2
    aQDl9uTW1HIvAHctzoyqp+1Vfk4heM4MbhcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526937916; bh=BA6ifrJ0wEs+oCkQ9QWJuOrry4ZK8u
    ITY/7TTvRRBLk=; b=hZHAjUQ8dKq2RaQDwsuSrYTVsoEMGVYfM6j4RCuT1PBuXH
    s3mWLQoxDT81w8q+nzGOTBBIFJtspL2HnCuXQteNyEOqGUn1jW0Hxsj6bCUU1OhV
    LHexb4VD+rGohuhr1ySelaOArdXPl7JSTw/VXqaaih4IchSZPMVQ42/ek2pZSFTF
    3Snv967iSwol5WnDY7Yl5xGY8K2Xxi1N32j3kZZEqScfAHJLye4N9T/IsLaNGq2x
    Y4oPS/uMnqsyGIYJadqhpRPt5+ampzUl0jlrcCw1nUONWRDYnCWlV9OBNAMcw1k0
    eHOI6KYy0NQhCmnlHObFtrVcuLSQbPHIoCRFeokA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=hDWyVnaD x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=hDWyVnaD x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfN1rM25griGVU8VW0HsSD3MJCR9Agb0V7S86pkESGg879SuB+M+583cCHhaYSYOgIK4vQCOQ0oaCjZbbaGfO/BPPEJmFj5isVdqtzaADZhDQPgEaJzaA
    /OmolaNhuFrS4y0C1EL3PzB1GOtsP0fWD41i+TZs7GnqDZM3SrcR5AabbrQLtz1gzy6DB5UNzYAbzzyIvTsLfsou+qmEKVvIO/OTpN0P+fc6zjTv504TgYMO
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=3HDBlxybAAAA:8 a=ag1SF4gXAAAA:8 a=lc5_RKDeiTAuVUZirQIA:9
    a=QEXdDO2ut3YA:10 a=laEoCiVfU_Unz3mSdgXN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932387AbeEUVZN (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:25:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:40048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932166AbeEUVZK (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:25:10 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fengguang Wu <fengguang.wu@intel.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.16 028/110] netfilter: nf_tables: nf_tables_obj_lookup_byhandle() can be static
Date: Mon, 21 May 2018 23:11:25 +0200
Message-Id: <20180521210506.302731397@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
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

From: kbuild test robot <fengguang.wu@intel.com>

commit ae0662f84b105776734cb089703a7bf834bac195 upstream.

Fixes: 3ecbfd65f50e ("netfilter: nf_tables: allocate handle and delete objects via handle")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nf_tables_api.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4399,9 +4399,9 @@ struct nft_object *nf_tables_obj_lookup(
 }
 EXPORT_SYMBOL_GPL(nf_tables_obj_lookup);
 
-struct nft_object *nf_tables_obj_lookup_byhandle(const struct nft_table *table,
-						 const struct nlattr *nla,
-						 u32 objtype, u8 genmask)
+static struct nft_object *nf_tables_obj_lookup_byhandle(const struct nft_table *table,
+							const struct nlattr *nla,
+							u32 objtype, u8 genmask)
 {
 	struct nft_object *obj;
 
@@ -4921,7 +4921,7 @@ struct nft_flowtable *nf_tables_flowtabl
 }
 EXPORT_SYMBOL_GPL(nf_tables_flowtable_lookup);
 
-struct nft_flowtable *
+static struct nft_flowtable *
 nf_tables_flowtable_lookup_byhandle(const struct nft_table *table,
 				    const struct nlattr *nla, u8 genmask)
 {
