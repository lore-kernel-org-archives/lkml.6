Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9483C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2EEE21841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfBTUuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:50:51 -0500
Received: from namei.org ([65.99.196.166]:53332 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbfBTUuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:50:51 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x1KKoV9w001602;
        Wed, 20 Feb 2019 20:50:31 GMT
Date:   Thu, 21 Feb 2019 07:50:31 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     David Howells <dhowells@redhat.com>
cc:     David Laight <David.Laight@ACULAB.COM>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KEYS: user: Align the payload buffer
In-Reply-To: <16012.1550671795@warthog.procyon.org.uk>
Message-ID: <alpine.LRH.2.21.1902210750180.1411@namei.org>
References: <6bf441ffc1a54d06ad27ed01c6d06a58@AcuMS.aculab.com> <155066953188.21038.12015964986007814182.stgit@warthog.procyon.org.uk> <16012.1550671795@warthog.procyon.org.uk>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2019, David Howells wrote:

> David Laight <David.Laight@ACULAB.COM> wrote:
> 
> > I'd make the 'datalen' field 'unsigned int' at the same time.
> > It will use some of the hole you've made and generate better
> > code on most arches.
> 
> Most arches?  I though most, if not all, arches had a load-word instruction.
> 
> Do you want to send me a patch for that?  I'd rather not alter this patch at
> this point.  I can pass the additional patch to James for the next merge
> window.

Should this first one go into -rc?


-- 
James Morris
<jmorris@namei.org>

