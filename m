Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031145AbeCSUBa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 16:01:30 -0400
Received: from verein.lst.de ([213.95.11.211]:33046 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030883AbeCSUBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 16:01:21 -0400
Date: Mon, 19 Mar 2018 21:01:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Cc: Scott Bauer <scott.bauer@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 10/11] block: sed-opal: get metadata about opal-sed
        tables
Message-ID: <20180319200120.GJ3380@lst.de>
References: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de> <cover.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de> <623d80cb07538e630a12a1c925e9c87b8e14dd6b.1521482296.git.jonas.rabenstein@studium.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <623d80cb07538e630a12a1c925e9c87b8e14dd6b.1521482296.git.jonas.rabenstein@studium.uni-erlangen.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 07:36:52PM +0100, Jonas Rabenstein wrote:
> Every opal-sed table is described in the OPAL_TABLE_TABLE. Provide a
> function to get desired metadata information out of that table.

Your new function doesn't seem to be used at all.
