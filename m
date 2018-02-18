Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751510AbeBRNZl (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 08:25:41 -0500
Received: from mail-qk0-f171.google.com ([209.85.220.171]:43439 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751377AbeBRNZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 08:25:39 -0500
X-Google-Smtp-Source: AH8x227vPYilf5irBxJhSrdKM7I5WAcZOxUjpeLs0bmnSRtPJmqDv/l97vkfGjh0IANzy2HdvFk9Ew==
Date: Sun, 18 Feb 2018 05:25:35 -0800
From: Tejun Heo <tj@kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/3] pata_macio: Delete an error message for a failed
 memory allocation in two functions
Message-ID: <20180218132535.GE695913@devbig577.frc2.facebook.com>
References: <1e87cf7d-eda2-12d9-af01-17f6619cda72@users.sourceforge.net>
 <0e764e7d-98cf-7f4e-91ff-bf82aa381442@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e764e7d-98cf-7f4e-91ff-bf82aa381442@users.sourceforge.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 01:38:20PM +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 16 Feb 2018 13:01:45 +0100
> 
> Omit an extra message for a memory allocation failure in these functions.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Applying this one but not the other two.

Thanks.

-- 
tejun
