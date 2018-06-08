Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id bOkcGUD/Glu7EQAAmS7hNA
	; Fri, 08 Jun 2018 22:12:16 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4B483607DC; Fri,  8 Jun 2018 22:12:16 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="olOUMY6u"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BC1F0605A2;
	Fri,  8 Jun 2018 22:12:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BC1F0605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753111AbeFHWMN (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 18:12:13 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:35396 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752910AbeFHWML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 18:12:11 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w58MB3f4153496;
        Fri, 8 Jun 2018 22:12:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=kl0NOP9YC7OwWK81czVvbFG/vjgUpHmdbmKweljvZ6s=;
 b=olOUMY6u/fGhrl5F2VvpGpMquw2AfMURhkxLqqeugD/fGQ4oxgrFHRQ8YqJVMSlM0A5V
 M4yw01N86sBw+ta9HiP7TGOy/V4ZZCXnVxSyYqMyJj6QtAIM8rcTpaLMLsb8GgQreUFJ
 Y5IMSjeT0D1e1Qp98oLKtJNIOQ1OUdwcqSTpcLKGic12PxjyTMOrESLNlWG9MLq/aNty
 rzjVvwhPyuuaAdF0vDrPgQ2fSFEBaBpmSXFehn+KvXLtnM0TmO6AoFzjajkgQyXpQ9H7
 az8rxm9fyAXkrShveIuI9m8ZYlYcumC36IeznFRVlXASGgQ4lF1un9MEBLQ11Cra+rCX tg==
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2jbvypf2sh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Jun 2018 22:12:07 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w58MC5jR000864
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Jun 2018 22:12:05 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w58MC5PO007932;
        Fri, 8 Jun 2018 22:12:05 GMT
Received: from mwanda (/41.202.241.42)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 Jun 2018 15:12:04 -0700
Date: Sat, 9 Jun 2018 01:11:54 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Chris Opperman <eklikeroomys@gmail.com>
Cc: devel@driverdev.osuosl.org, Frank Mori Hess <fmh6jj@gmail.com>,
        Simo Koskinen <koskisoft@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>
Subject: Re: [PATCH] Fixed coding style problems.
Message-ID: <20180608221154.zghkrw5sc6zjtmaz@mwanda>
References: <1528483959-23158-1-git-send-email-eklikeroomys@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528483959-23158-1-git-send-email-eklikeroomys@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8918 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=916
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806080237
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The subject should be:

[PATCH] staging: comedi: shorten a long line

or something.  You need the subsystem prefix.  Try not to be vague.


On Fri, Jun 08, 2018 at 08:52:37PM +0200, Chris Opperman wrote:
> This patch fixes a coding style problem in drivers/staging/comedi/drivers.c
> and is submitted for task 10 of the eudyptula challenge.
> Signed-off-by: Chris Opperman <eklikeroomys@gmail.com>

You need a blank line before the Signed-off-by line.

Best not to mention eudyptula.  The patch should be a readability
improvement which justifies itsefl.

> ---
>  drivers/staging/comedi/drivers.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/comedi/drivers.c b/drivers/staging/comedi/drivers.c
> index 9d73347..90ee974 100644
> --- a/drivers/staging/comedi/drivers.c
> +++ b/drivers/staging/comedi/drivers.c
> @@ -475,7 +475,8 @@ unsigned int comedi_nsamples_left(struct comedi_subdevice *s,
>  	struct comedi_cmd *cmd = &async->cmd;
>  
>  	if (cmd->stop_src == TRIG_COUNT) {
> -		unsigned int scans_left = __comedi_nscans_left(s, cmd->stop_arg);
> +		unsigned int scans_left =
> +			__comedi_nscans_left(s, cmd->stop_arg);

This isn't really a readability improvement.  Checkpatch.pl is not the
king of the world.  It's only useful so far as it improves readability.

We would still have accepted the patch probably but the format wasn't
right because of the subject line.

>  		unsigned int scan_pos =
>  		    comedi_bytes_to_samples(s, async->scan_progress);
>  		unsigned long long samples_left = 0;

regards,
dan carpenter
