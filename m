Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427016AbeBORIu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 12:08:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:52900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1422885AbeBORIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 12:08:45 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E86D020C51
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Thu, 15 Feb 2018 14:08:42 -0300
From: "'Arnaldo Carvalho de Melo'" <acme@kernel.org>
To: Robert Walker <robert.walker@arm.com>
Cc: "'Mathieu Poirier'" <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        coresight@lists.linaro.org
Subject: Re: [PATCH 2/2] perf inject: Emit instruction records on ETM trace
 discontinuity
Message-ID: <20180215170842.GJ30974@kernel.org>
References: <1518011845-24063-1-git-send-email-robert.walker@arm.com>
 <1518011845-24063-3-git-send-email-robert.walker@arm.com>
 <20180213222233.GA23553@xps15>
 <20180215145714.GE30974@kernel.org>
 <001901d3a670$da940cc0$8fbc2640$@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001901d3a670$da940cc0$8fbc2640$@arm.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 15, 2018 at 03:22:52PM -0000, Robert Walker escreveu:
> > From: Arnaldo Carvalho de Melo [mailto:acme@kernel.org]
> > 	Can you please address Mathieu's comments, and if you agree with
> > them, resubmit?

> Hi Arnaldo,
 
> I've addressed Mathieu's comments and resubmitted them yesterday
> (https://lkml.org/lkml/2018/2/14/185).

Thanks, I'm processing them now,

- Arnaldo
