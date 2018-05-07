Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752545AbeEGQ1r (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 12:27:47 -0400
Received: from mail-yb0-f172.google.com ([209.85.213.172]:36757 "EHLO
        mail-yb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752081AbeEGQ1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 12:27:46 -0400
X-Google-Smtp-Source: AB8JxZpYAMmYyN50JqwyWib2nXb5gnu2ObYY28QLDkhQS1kahcKIEKGeEGw8d6eYr05HxiHnMUxrMQ==
Date: Mon, 7 May 2018 09:27:43 -0700
From: Tejun Heo <tj@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Parav Pandit <pandit.parav@gmail.com>
Subject: Re: [PATCH v2] rdmacg: Convert to use match_string() helper
Message-ID: <20180507162743.GI2368884@devbig577.frc2.facebook.com>
References: <20180504144216.60262-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504144216.60262-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 05:42:16PM +0300, Andy Shevchenko wrote:
> The new helper returns index of the matching string in an array.
> We are going to use it here.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to cgroup/for-4.18.

Thanks.

-- 
tejun
