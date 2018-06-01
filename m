Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751335AbeFAJQZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 05:16:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750850AbeFAJQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 05:16:24 -0400
Date: Fri, 1 Jun 2018 11:15:53 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sankalp Negi <sankalpnegi2310@gmail.com>
Cc: devel@driverdev.osuosl.org, NeilBrown <neil@brown.name>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: mt7621-spi: Fix Coding style issues reported by
 checkpatch.pl.
Message-ID: <20180601091553.GA5821@kroah.com>
References: <20180531185542.phhu2rkdoq2czkav@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180531185542.phhu2rkdoq2czkav@localhost>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 12:25:43AM +0530, Sankalp Negi wrote:
> This patch fixes following checkpatch.pl issues:
> 
> WARNING : line over 80 characters
> ERROR   : code indent should use tabs where possible
> WARNING : no spaces at the start of a line
> ERROR   : switch and case should be at the same indent
> ERROR   : space required before the open parenthesis
> WARNING : braces {} are not necessary for single statement blocks

Those are all different types of coding style cleanups and should be
done as a patch series, only fixing up one "type" of thing at a time.

thanks,

greg k-h
