Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1A6C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29EA021872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfBAX3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 18:29:13 -0500
Received: from namei.org ([65.99.196.166]:49780 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbfBAX3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 18:29:12 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x11NSdWD025026;
        Fri, 1 Feb 2019 23:28:39 GMT
Date:   Sat, 2 Feb 2019 10:28:39 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] security: mark expected switch fall-throughs
In-Reply-To: <ece10676-4ee9-bf24-ab8d-7d69a678f234@embeddedor.com>
Message-ID: <alpine.LRH.2.21.1902021028320.24863@namei.org>
References: <20190125025639.GA13946@embeddedor> <d30c9427-29bb-4b98-ec71-0663d0f9fa7f@schaufler-ca.com> <7b0a0b5b-38ce-a737-6420-2c96cce12527@embeddedor.com> <f9ca33c7-2f96-ce1f-4fd2-587b991f2e85@embeddedor.com> <1548964731.6107.28.camel@linux.ibm.com>
 <a1cf3a2a-c8ad-fd33-47fb-9a9d8230c24f@embeddedor.com> <1548966039.6107.29.camel@linux.ibm.com> <ece10676-4ee9-bf24-ab8d-7d69a678f234@embeddedor.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1665246916-1580712791-1549063719=:24863"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1665246916-1580712791-1549063719=:24863
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Thu, 31 Jan 2019, Gustavo A. R. Silva wrote:

> 
> 
> On 1/31/19 2:20 PM, Mimi Zohar wrote:
> 
> >>>
> >>> This patch touches multiple LSMs and IMA.  As James has already picked
> >>> up similar patches, which are in his next-general branch, perhaps he
> >>> could also pick up an updated version of this one.
> >>>
> >>
> >> Yeah.  I can either integrate your recent fix and respin if you don't mind,
> >> or remove the fall-through comment and wait for James to take both patches,
> >> yours and mine.
> >>
> >> What do you prefer?
> > 
> > Either way is fine.
> > 
> 
> OK.  Well, I think in this case less is more, so I will integrate our changes
> into a single patch.

WFM

-- 
James Morris
<jmorris@namei.org>

--1665246916-1580712791-1549063719=:24863--
