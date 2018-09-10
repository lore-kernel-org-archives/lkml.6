Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733E1C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E09220854
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E09220854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbeIJXPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 19:15:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44672 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbeIJXP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 19:15:29 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C5B40115E;
        Mon, 10 Sep 2018 18:20:08 +0000 (UTC)
Date:   Mon, 10 Sep 2018 20:20:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     Bin Liu <b-liu@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukasz Tyrala <ltyrala@cadence.com>,
        Alan Douglas <adouglas@cadence.com>
Subject: Re: [PATCH 00/31] Introduced new Cadence USBSSP DRD Driver
Message-ID: <20180910182005.GC6019@kroah.com>
References: <1532023084-28083-1-git-send-email-pawell@cadence.com>
 <20180817210534.GA11144@uda0271908>
 <BYAPR07MB47091F95E8AB1400865E21DDDD310@BYAPR07MB4709.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR07MB47091F95E8AB1400865E21DDDD310@BYAPR07MB4709.namprd07.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 02:50:19PM +0000, Pawel Laszczak wrote:
> Hi,
> 
> USBSSP it's the project name and it was the reason for such prefix.
> 
> I agree with you that the shorter prefix could be better and we could get rid of some warnings reported by checkpatch. Currently we have more important issues related to testing and debugging driver so decision about change I leave for the feature.   Such modification could be made as separate single patch. 

No, get it right at the beginning please.  Having "my function names are
too long" errors right when you first submit the code implies that you
don't really care about meeting our normal coding style rules.

Now of course I _know_ you don't mean to imply that at all, right?  :)

thanks,

greg k-h
