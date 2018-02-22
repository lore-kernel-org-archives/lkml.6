Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933165AbeBVQC1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 11:02:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:49580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933085AbeBVQCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 11:02:22 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB4EE2178B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=abelloni@kernel.org
Date: Thu, 22 Feb 2018 17:02:20 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 000/100] rtc: remove cargo culted code
Message-ID: <20180222160220.GL31244@piout.net>
References: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
 <20180222154802.GA2114@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222154802.GA2114@infradead.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2018 at 07:48:03 -0800, Christoph Hellwig wrote:
> On Wed, Feb 21, 2018 at 09:54:55PM +0100, Alexandre Belloni wrote:
> > Hello,
> > 
> > This series:
> >  - removes useless calls to rtc_valid_tm in .read_time, .set_time and
> >    .set_alarm
> >  - removes code setting default values for RTCs (and lets the core
> >    handle it)
> >  - removes useless "time is invalid" messages at probe time
> >  - removes useless indirect calls
> 
> Seems like this could be just one patch for each of the issues..

I'll probably squash the simpler ones before sending to Linus.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
