Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970975AbeCSTxm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 15:53:42 -0400
Received: from verein.lst.de ([213.95.11.211]:32960 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S969418AbeCSTxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 15:53:36 -0400
Date: Mon, 19 Mar 2018 20:53:35 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Cc: Scott Bauer <scott.bauer@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 00/11] block: sed-opal support write to shadow mbr
Message-ID: <20180319195335.GB3380@lst.de>
References: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de> <cover.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 07:36:42PM +0100, Jonas Rabenstein wrote:
> Hi,
> I was advised to resend the patchset as a v2 where all the patches are
> in a flat hierarchy. So here is a complete set which hopefully pleases
> all requirements.
> As the previous fixes have by now all landed into linux-next, no
> additional patches are required for testing.

Btw, what userspace do you use for this?  The only one I know so far
is Scotts sed-opal-temp, which really should grow a more permanent
name / location.
