Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0290EC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB3DE23C9B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:14:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB3DE23C9B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753341AbeGBJOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 05:14:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49218 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753281AbeGBJON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 05:14:13 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 834E4ACC;
        Mon,  2 Jul 2018 09:14:12 +0000 (UTC)
Date:   Mon, 2 Jul 2018 11:14:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Whitmore <johnfwhitmore@gmail.com>
Cc:     devel@driverdev.osuosl.org, kstewart@linuxfoundation.org,
        linux-kernel@vger.kernel.org, pombredanne@nexb.com,
        tglx@linutronix.de
Subject: Re: [PATCH 1/3] staging: rtl8192u: Use __func__ instead of hardcoded
 string - Style
Message-ID: <20180702091410.GA7140@kroah.com>
References: <20180629181007.18071-1-johnfwhitmore@gmail.com>
 <20180629181007.18071-2-johnfwhitmore@gmail.com>
 <20180702084133.GA25960@kroah.com>
 <CAA_1HzEkZZmE1skOs=mLNFfKf9aBnR_bunddh_fcYX=RhcprzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA_1HzEkZZmE1skOs=mLNFfKf9aBnR_bunddh_fcYX=RhcprzA@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 09:59:34AM +0100, John Whitmore wrote:
> I'll fix that up and re-submit 

Please do not top-post, or send html email, as the mailing lists will
reject it (as you saw...)

greg k-h
