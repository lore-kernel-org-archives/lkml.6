Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751706AbeBBMJ0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 07:09:26 -0500
Received: from mga18.intel.com ([134.134.136.126]:44015 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751416AbeBBMJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 07:09:20 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,448,1511856000";
   d="scan'208";a="15370706"
Date: Fri, 2 Feb 2018 14:09:16 +0200
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Alexandre Courbot <acourbot@chromium.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFCv2 00/17] Request API, take three
Message-ID: <20180202120916.blkgr2hafau4h4l6@paasikivi.fi.intel.com>
References: <20180131102427.207721-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180131102427.207721-1-acourbot@chromium.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On Wed, Jan 31, 2018 at 07:24:18PM +0900, Alexandre Courbot wrote:
> This is a quickly-put together revision that includes and uses Hans' work to
> use v4l2_ctrl_handler as the request state holder for V4L2 devices. Although
> minor fixes have also been applied, there are still a few comments from the
> previous revision that are left unaddressed. I wanted to give Hans something
> to play with before he forgets what he had in mind for controls. ;)

Could you rebase this on the current media master, please?

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
