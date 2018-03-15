Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751881AbeCOIFA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 04:05:00 -0400
Received: from verein.lst.de ([213.95.11.211]:39903 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751481AbeCOIE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 04:04:56 -0400
Date: Thu, 15 Mar 2018 09:04:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH, RFC] block: remove the paride drivers
Message-ID: <20180315080455.GA12388@lst.de>
References: <20180315075256.25652-1-hch@lst.de> <201803150904.25087.linux@rainbow-software.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201803150904.25087.linux@rainbow-software.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 09:04:24AM +0100, Ondrej Zary wrote:
> On Thursday 15 March 2018, Christoph Hellwig wrote:
> > The paride drivers are some of the cruftiest, grottiest block drivers
> > (besides drivers/ide and floppy.c) and have seen one single targeted
> > commit since the dawn of git in 2007.  Drop them to make block layer
> > improvements easier.
> 
> This will make my parallel port ZIP and LS-120 drives useless :(

So you are still using them and the code actually works properly?
