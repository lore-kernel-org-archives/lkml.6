Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEE1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 942C7208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:12:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 942C7208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388959AbeKPGVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 01:21:44 -0500
Received: from smtprelay0197.hostedemail.com ([216.40.44.197]:36225 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725787AbeKPGVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 01:21:44 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 57923180A68C4;
        Thu, 15 Nov 2018 20:12:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: shame26_6c8b45981e060
X-Filterd-Recvd-Size: 3264
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Thu, 15 Nov 2018 20:12:25 +0000 (UTC)
Message-ID: <4a97926d76be9382051f438c4254cb534105c48b.camel@perches.com>
Subject: Re: [Ksummit-discuss] [RFC PATCH 1/3] MAINTAINERS: Reclaim the P:
 tag for Subsystem Profile
From:   Joe Perches <joe@perches.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Ben Dooks <ben-linux@fluff.org>
Cc:     linux-kernel@vger.kernel.org, vishal.l.verma@intel.com,
        linux-nvdimm@lists.01.org,
        ksummit-discuss@lists.linuxfoundation.org
Date:   Thu, 15 Nov 2018 12:12:24 -0800
In-Reply-To: <20181114213901.75768212@silica.lan>
References: <154225759358.2499188.15268218778137905050.stgit@dwillia2-desk3.amr.corp.intel.com>
         <154225759959.2499188.5163439674278041458.stgit@dwillia2-desk3.amr.corp.intel.com>
         <20181114213901.75768212@silica.lan>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-11-14 at 21:39 -0800, Mauro Carvalho Chehab wrote:
> Em Wed, 14 Nov 2018 20:53:19 -0800
> Dan Williams <dan.j.williams@intel.com> escreveu:
> 
> > Fixup some P: entries to be M: and rename the remaining ones to 'E:' for
> > "entity". The P: tag will be used to indicate the location of a
> > Subsystem Profile for a given MAINTAINERS entry.
> > 
> > Cc: Joe Perches <joe@perches.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  MAINTAINERS |   18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 0abecc528dac..83b7b3943a12 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -76,7 +76,7 @@ trivial patch so apply some common sense.
> >  
> >  Descriptions of section entries:
> >  
> > -	P: Person (obsolete)
> > +	E: Entity (obsolete)
> 
> I don't like very much the idea of renaming it, but that's just my 2 cents.

I'd prefer just removing all the "P:" entries.

[]
> > @@ -13577,15 +13577,15 @@ F:	drivers/video/fbdev/simplefb.c
> >  F:	include/linux/platform_data/simplefb.h
> >  SIMTEC EB110ATX (Chalice CATS)
> > -P:	Ben Dooks
> > -P:	Vincent Sanders <vince@simtec.co.uk>
> > +E:	Ben Dooks
> > +M:	Vincent Sanders <vince@simtec.co.uk>
> >  M:	Simtec Linux Team <linux@simtec.co.uk>
> >  W:	http://www.simtec.co.uk/products/EB110ATX/
> >  S:	Supported

This is an ancient StrongARM based board that is shown as
discontinued on Simtec's website.
This is very obsolete and it's probably better to remove it.

> >  SIMTEC EB2410ITX (BAST)
> > -P:	Ben Dooks
> > -P:	Vincent Sanders <vince@simtec.co.uk>
> > +E:	Ben Dooks
> > +M:	Vincent Sanders <vince@simtec.co.uk>
> >  M:	Simtec Linux Team <linux@simtec.co.uk>
> >  W:	http://www.simtec.co.uk/products/EB2410ITX/
> >  S:	Supported
[]
> So, I guess this information is duplicated/obsoleted and could just 
> be removed.

This one is still listed as a production board on Simtec's website.
http://www.simtec.co.uk/products/EB2410ITX/

But I expect these 2410 boards aren't sold in any volume.


