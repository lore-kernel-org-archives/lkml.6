Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934041AbeCMQSw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:18:52 -0400
Received: from mga02.intel.com ([134.134.136.20]:23448 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752281AbeCMQSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:18:49 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,465,1515484800";
   d="scan'208";a="24166277"
Date: Tue, 13 Mar 2018 09:53:38 -0600
From: Scott Bauer <scott.bauer@intel.com>
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Cc: Jonathan Derrick <jonathan.derrick@intel.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] block: sed-opal: support write to shadow mbr
Message-ID: <20180313155337.uz6uxdpeonbjwa2l@sbauer-Z170X-UD5>
References: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 02:08:53PM +0100, Jonas Rabenstein wrote:
> Hi,
> this patchset adds support to write data into the shadow mbr of sed-opal
> enabled devices. They apply cleanly on today next-tree (next-20180313)
> and requires the u64 short atom length fix from [0] as that is still
> missing in that tree. As I only can test on my only sed-opal enabled
> Samsung 850 Evo on amd64, tests on other hardware would be appreciated.

Generally the series looks fine, there are a few nits I've sent out.
I will test and get back to you in the next day or two. With any further
comments.
