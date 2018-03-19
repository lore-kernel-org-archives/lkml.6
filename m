Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969508AbeCST64 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 15:58:56 -0400
Received: from verein.lst.de ([213.95.11.211]:33004 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S969031AbeCST6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 15:58:52 -0400
Date: Mon, 19 Mar 2018 20:58:50 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Cc: Scott Bauer <scott.bauer@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 05/11] block: sed-opal: print failed function address
Message-ID: <20180319195850.GG3380@lst.de>
References: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de> <cover.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de> <9c333dc3b35cf9c43061567837de32bf154c2fe4.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c333dc3b35cf9c43061567837de32bf154c2fe4.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 07:36:47PM +0100, Jonas Rabenstein wrote:
> Add function address (and if available its symbol) to the message if a
> step function fails.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
