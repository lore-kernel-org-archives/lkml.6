Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B527CC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 06:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7B62064C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 06:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AAWnigQG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A7B62064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbeJWOtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 10:49:16 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50710 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbeJWOtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 10:49:16 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9N6NfYT096546;
        Tue, 23 Oct 2018 06:27:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=/N9QV/QBp9+cdyWU0JKDLoh69mampezDCpO8hjxKSaw=;
 b=AAWnigQGok78PN4HuT8lOa9mrd33e2l9IEp4J8lOTcUt5yhZPTUMU7GN1QTpsZAGY7YG
 fjH8K9ObiIjQ56/UYebu1rdDbCLN7UVKLG+PolrGc3wIxhzEkJaP5iQy0IUGz6C51yCq
 KZpPeRa+lk/aJrgeHr4edkqC+1F/zKjwc9STxdYKW8GT//sXD3MTN4cZ6h5I4vapMSb8
 jm+1VwvPeDqQmhuMz1TXPeBcJgcdVRAsCDsYYc5wbrjgTgKyihYZLVGBOspWsM0ZbfZm
 Wy9LpyQMK7baWOX8glvig+W1wWJ0A0+oFSfcXiB0agUYOee8It05xHWdzqgl7T5wVOK5 Vg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2n7vaptxwd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Oct 2018 06:27:08 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9N6R7bg021190
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Oct 2018 06:27:07 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9N6R6wh004668;
        Tue, 23 Oct 2018 06:27:06 GMT
Received: from mwanda (/129.205.6.86)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Oct 2018 23:27:05 -0700
Date:   Tue, 23 Oct 2018 09:26:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, NeilBrown <neil@brown.name>,
        Josh Triplett <josh@joshtriplett.org>,
        Mishi Choudhary <mishi@linux.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org
Subject: Re: [Ksummit-discuss] Call to Action Re: [PATCH 0/7] Code of
 Conduct: Fix some wording, and add an interpretation document
Message-ID: <20181023062652.yrns7n67jkuict5n@mwanda>
References: <20181020134908.GA32218@kroah.com>
 <87y3ar80ac.fsf@notabene.neil.brown.name>
 <20181021222608.GA24845@localhost>
 <875zxt919d.fsf@notabene.neil.brown.name>
 <20181022224604.GM1617@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022224604.GM1617@thunk.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9054 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810230057
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 06:46:04PM -0400, Theodore Y. Ts'o wrote:
> Neil,
> 
> I disagree with your framing, and thus your analysis, and thus your
> proposed solution.
> 
> On Tue, Oct 23, 2018 at 07:26:06AM +1100, NeilBrown wrote:
> > If, for example, Linus or Andrew said "if you cannot work with any given
> > maintainer, I will consider your patch directly, but you need to point
> > to where you tried, and why you failed - or to where the promise is
> > inadequate".
> > 
> > Currently if a maintainer is rude to you, there is no where else that
> > you can go and *that* is why it hurts.  It isn't the abuse so much as
> > the powerlessness associated with it.  If you can (metaphorically) say
> > to that maintainer "I don't care about your toilet mouth, you've just
> > given me the right to take my petition to caesar" - then the emotional
> > response will be quite different to pain.
> 
> No.  That's just not how things work.  Patches don't get rejected
> because maintainers are being rude.  Patches don't get accepted
> because they are not of a sufficiently high technical quality.

I once sent a bugfix and instead of applying it, the maintainer insulted
me and rejected it because the subject wasn't in imperative tense and
because I said "NULL dereference" instead of "NULL pointer dereference."

Ten years back there was a patch rejected because "F*** you, what do
women know about programming?"  I can't imagine it happening now, but I
was so shocked by it at the time also...

regards,
dan carpenter

