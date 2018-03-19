Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971006AbeCSTy0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 15:54:26 -0400
Received: from verein.lst.de ([213.95.11.211]:32973 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968513AbeCSTyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 15:54:22 -0400
Date: Mon, 19 Mar 2018 20:54:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Cc: Scott Bauer <scott.bauer@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 02/11] block: sed-opal: unify space check in
        add_token_*
Message-ID: <20180319195421.GD3380@lst.de>
References: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de> <cover.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de> <955fd10854ed68f6925612ae73cdaa4637cfb5e4.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <955fd10854ed68f6925612ae73cdaa4637cfb5e4.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 07:36:44PM +0100, Jonas Rabenstein wrote:
> All add_token_* functions have a common set of conditions that have to
> be checked. Use a common function for those checks in order to avoid
> different behaviour as well as code duplication.
> 
> Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
