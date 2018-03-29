Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752258AbeC2Ra1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 13:30:27 -0400
Received: from mx-rz-3.rrze.uni-erlangen.de ([131.188.11.22]:36605 "EHLO
        mx-rz-3.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751182AbeC2Ra0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 13:30:26 -0400
Authentication-Results: mx-rz-3.rrze.uni-erlangen.de; dkim=none
        reason="no signature"; dkim-adsp=none (unprotected policy);
        dkim-atps=neutral
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 204.85.191.31
Date: Thu, 29 Mar 2018 19:30:02 +0200
From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
To: Scott Bauer <scott.bauer@intel.com>
Cc: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        Christoph Hellwig <hch@lst.de>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/11] block: sed-opal: ioctl for writing to shadow mbr
Message-ID: <20180329173002.5mmhnl4urj4wovyo@studium.uni-erlangen.de>
References: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de>
 <cover.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de>
 <9f94be9c32887aacdcba75bd6a3902d0350eb987.1521482296.git.jonas.rabenstein@studium.uni-erlangen.de>
 <20180319195224.GA3380@lst.de>
 <20180320093604.qge2sdnc5jrud6kg@studium.uni-erlangen.de>
 <20180320220907.zdzf7baag6haaonm@sbauer-Z170X-UD5>
 <20180321014321.xlkcyvcyr6j3usix@studium.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321014321.xlkcyvcyr6j3usix@studium.uni-erlangen.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Wed, Mar 21, 2018 at 02:43:21AM +0100, Jonas Rabenstein wrote:
> On Tue, Mar 20, 2018 at 04:09:08PM -0600, Scott Bauer wrote:
> > On Tue, Mar 20, 2018 at 10:36:04AM +0100, Jonas Rabenstein wrote:
> > > On Mon, Mar 19, 2018 at 08:52:24PM +0100, Christoph Hellwig wrote:
> > > > On Mon, Mar 19, 2018 at 07:36:50PM +0100, Jonas Rabenstein wrote:
> > > > I hate doing this as an ioctls.  Can we make this a sysfs binary file
> > > > so that people can use dd or cat to write the shadow mbr?
> > > I already thought about providing a sysfs interface for all that instead
> > > of using ioctls. But as I am pretty new to kernel programming I do not
> > > have all the required insight. Especially, as writing the mbr requires
> > > the sed-opal password I am unsure how a clean sysfs interface to provide
> > > the password together with a simple dd would look like.
Just wanted to ask, how to proceed with those patches/what I should do.
Using sysfs instead of an ioctl is probably easier to use from userspace
_if_ there is a good way to provide the password - which I do not know
of :(
If nobody else could think of a solution, shall writes to the shadow mbr
remain unsupported?

I'ld really appreciate feedback and possible solutions,
 Jonas
