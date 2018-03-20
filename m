Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751682AbeCTUHH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 16:07:07 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:34703 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751646AbeCTUHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 16:07:04 -0400
X-Google-Smtp-Source: AG47ELvv1yi6438HOJXqV6g9UxFhtCtnvGOjAFNtHHmHLV+dINn2yeICX4Z0x+VKY/GpStM7HkuZ3Q==
Date: Tue, 20 Mar 2018 13:07:01 -0700
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: remove the comment about the old manager_arb
 mutex
Message-ID: <20180320200701.GN519464@devbig577.frc2.facebook.com>
References: <20180320092432.13141-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320092432.13141-1-jiangshanlai@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 05:24:32PM +0800, Lai Jiangshan wrote:
> The manager_arb mutex doesn't exist any more.
> 
> Signed-off-by: Lai Jiangshan <jiangshanlai@gmail.com>

Applied to wq/for-4.17.

Thanks.

-- 
tejun
