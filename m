Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751338AbeEKTpL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 15:45:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54814 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750722AbeEKTpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 15:45:10 -0400
Date: Fri, 11 May 2018 13:45:09 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Baptiste Reynal <b.reynal@virtualopensystems.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vfio: platform: Make printed error messages more
 consistent
Message-ID: <20180511134509.3201eb54@w520.home>
In-Reply-To: <1523372051-23716-1-git-send-email-geert+renesas@glider.be>
References: <1523372051-23716-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Apr 2018 16:54:11 +0200
Geert Uytterhoeven <geert+renesas@glider.be> wrote:

>   - Capitalize the first word of error messages,
>   - Unwrap statements that fit on a single line,
>   - Use "VFIO" instead of "vfio" as the error message prefix.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> ---
> v2:
>   - Add Reviewed-by.
> ---
>  drivers/vfio/platform/vfio_platform_common.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Applied to next branch for v4.18 with Eric's ack, Thanks,

Alex
