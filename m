Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753079AbeCMU0b (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 16:26:31 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:46638 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753038AbeCMU00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 16:26:26 -0400
X-Google-Smtp-Source: AG47ELuVu6M/Pq5+bWPxpeva8zwTApuMP/z9059M2J3YCD5IhIYjYGC1+ngx94xL2AArJNhWaHeWJg==
Date: Tue, 13 Mar 2018 13:26:23 -0700
From: Tejun Heo <tj@kernel.org>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] workqueue: use put_device() instead of kfree()
Message-ID: <20180313202623.GH2943022@devbig577.frc2.facebook.com>
References: <1520330743-20445-1-git-send-email-arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520330743-20445-1-git-send-email-arvind.yadav.cs@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2018 at 03:35:43PM +0530, Arvind Yadav wrote:
> Never directly free @dev after calling device_register(), even
> if it returned an error! Always use put_device() to give up the
> reference initialized in this function instead.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Applied to wq/for-4.16-fixes.

Thanks.

-- 
tejun
