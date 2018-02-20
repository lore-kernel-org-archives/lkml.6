Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751417AbeBTVb4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 16:31:56 -0500
Received: from mail-qt0-f176.google.com ([209.85.216.176]:44092 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750774AbeBTVbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 16:31:53 -0500
X-Google-Smtp-Source: AH8x224HZYlsKZIH0tVjNEdlz2SMutHYzxILkGw4vr8kXnoydr/8Y2kTyOPAOBK9QFfs93vX/8BWWw==
Date: Tue, 20 Feb 2018 13:31:49 -0800
From: Tejun Heo <tj@kernel.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: hdegoede@redhat.com, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] libata: disable LPM for Crucial BX100 SSD 500GB drive
Message-ID: <20180220213149.GC170644@devbig577.frc2.facebook.com>
References: <20180218141709.24913-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180218141709.24913-1-kai.heng.feng@canonical.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 18, 2018 at 10:17:09PM +0800, Kai-Heng Feng wrote:
> After Laptop Mode Tools starts to use min_power for LPM, a user found
> out Crucial BX100 SSD can't get mounted.
> 
> Crucial BX100 SSD 500GB drive don't work well with min_power. This also
> happens to med_power_with_dipm.
> 
> So let's disable LPM for Crucial BX100 SSD 500GB drive.
> 
> BugLink: https://bugs.launchpad.net/bugs/1726930
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Applied to libata/for-4.16-fixes.

Thanks.

-- 
tejun
