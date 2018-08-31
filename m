Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4128C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 793E320839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kFdxHsIv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 793E320839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbeHaLbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 07:31:06 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37432 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbeHaLbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 07:31:06 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7V7OB1U165741;
        Fri, 31 Aug 2018 07:24:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=3T7uBIA/LDWSl+rBLPfmSFDC/MFCbXYS1/l8yJurzZk=;
 b=kFdxHsIvT2B+IW7f+sAWc+Sv1plE1SpqQBUNYXspEhfa/8pC8GToYZkOnn4zlp0gfW5H
 48aylXUCup28NKiN6ZA2SpXeEPtjJnH92mFpHCCNIp7Jm70CLVQ0U0OUdTw05+2pRcjI
 QnPUXCKibDeDf3Y6xaENd5r8n6vZiGG2e0LcrDb0ZN/YMt/3VTLBRNfxK+Qm8j0V93cW
 rknU0KgJFAZLsLiEJN8fqxDPQrhNgoK4bYM22CsnILWrY2EeR40SXG69x/oUIvkQQsJ+
 rvTakfb8RrDLrwYuEEtxjY191HyVT56WTtSydKp+IZh797PAwv1heoFDKRsc6IKqNPlP Lg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2m2xhu97mk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Aug 2018 07:24:58 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7V7OvHB011631
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Aug 2018 07:24:57 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7V7OuJ8013529;
        Fri, 31 Aug 2018 07:24:57 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 31 Aug 2018 00:24:56 -0700
Date:   Fri, 31 Aug 2018 10:24:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     John Whitmore <arigead@gmail.com>
Cc:     John Whitmore <johnfwhitmore@gmail.com>,
        devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/21] staging:rtl8192u: Rename AdvCoding - Style
Message-ID: <20180831072449.6zhkm4emdoiqfwyn@mwanda>
References: <20180829203547.15650-1-johnfwhitmore@gmail.com>
 <20180829203547.15650-2-johnfwhitmore@gmail.com>
 <20180830082305.umqtq3fdexlyvn65@mwanda>
 <20180830082628.ff5x3tzvd2wdrbir@mwanda>
 <20180830213536.GA2904@xux707-tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830213536.GA2904@xux707-tw>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9001 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808310079
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 10:35:37PM +0100, John Whitmore wrote:
> On Thu, Aug 30, 2018 at 11:26:28AM +0300, Dan Carpenter wrote:
> > On Thu, Aug 30, 2018 at 11:23:05AM +0300, Dan Carpenter wrote:
> > > On Wed, Aug 29, 2018 at 09:35:27PM +0100, John Whitmore wrote:
> > > > Rename the bit field element AdvCoding, as it causes a checkpatch issue
> > > > with CamelCase naming. As the element is not actually used in code it
> > > > has been renamed to 'not_used_adv_coding'.
> > > > 
> > > > The single line of code which initialises the bit has been removed,
> > > > as the  field is unused.
> > > > 
> > > > This is a purely coding style change which should have no impact
> > > > on runtime code execution.
> > > > 
> > > > Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
> > > > ---
> > > >  drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h     | 2 +-
> > > >  drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 1 -
> > > >  2 files changed, 1 insertion(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
> > > > index 64d5359cf7e2..66a0274077d3 100644
> > > > --- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
> > > > +++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
> > > > @@ -39,7 +39,7 @@ enum ht_extension_chan_offset {
> > > >  
> > > >  struct ht_capability_ele {
> > > >  	//HT capability info
> > > > -	u8	AdvCoding:1;
> > > > +	u8	not_used_adv_coding:1;
> > > 
> > > I can't review any more of this patchset when this is the first line...
> > > 
> > 
> > That email wasn't very clear.  If you think some of your patches are
> > going to be more controversial than others, put them at the very end so
> > we can at least apply part of the patchset.
> > 
> > regards,
> > dan carpenter
> > 
> 
> Thanks for the clarification, I needed it ;)
> 
> I'm not sure I consider any of the patches in the series as being
> controversial. They are all just simple name changes of member
> variables. As a number of the variables are not used in code the names
> have been changed to reflect that fact. If I'd renamed them and left out
> the 'not_used_' prefix would the changes not be controversial? I
> don't think the fact that the members are unused is a biggy.
> 

I didn't like the new name at all.

Quite often when I review these I just use a script to verify that we're
only renaming variables and not doing code changes outside of that.  But
if I review it by hand I would have seen that the variable was not used
and investigated what was going on.

> What might appear to be controversial is that I didn't simply remove
> the members. I haven't done that because I'm not yet satisfied that
> the structure's size is insignificant. As soon as I am happy that the
> size of the structure is not important, to runtime code execution,
> there'll be a patch which removes a number of 'not_used_...' members
> from a structure.
> 
> Alternatively if the size if important there might be a patch which
> renames a number of unused bitfield members to reserved_1, reserved_2,
> reserved_3....

That's a good question.  If a struct is part of the use space API or the
network protocol or defined by the hardware then we can't change the
layout.

One thing I look for is if the struct has pointers which aren't tagged
as __user pointers then it's internal to the kernel.  Unfortunately that
doesn't help here.  Network protocol is all endian specific and this
struct is not.  But again that doesn't help much because it could just
be a bug.  If the struct is __packed then obviously the layout matters.

So I don't know.  I think you're right that actually we can't change
the layout.  The code is really a mess, so it's possible I have misread.

regards,
dan carpenter

