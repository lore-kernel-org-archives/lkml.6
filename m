Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752074AbeB0Qht convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 11:37:49 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:9646 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751756AbeB0Qhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 11:37:48 -0500
X-RZG-AUTH: :P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9zW4DNhHoQE+naq7U3dqoIF772u3upuX3WYd8GKH5JPgOLYv8PYyujw==
X-RZG-CLASS-ID: mo00
From: Stephan Mueller <smueller@chronox.de>
To: Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>
Cc: linux-input@vger.kernel.org, marek.wyborski@emwesoft.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] input: bcm5974 - Add driver for Apple Magic Trackpad 2
Date: Tue, 27 Feb 2018 17:37:45 +0100
Message-ID: <1566223.3I8hjEaRec@tauon.chronox.de>
In-Reply-To: <2305311.UGlXl2onVb@positron.chronox.de>
References: <40764439.8xGR6LbaWR@positron.chronox.de> <2305311.UGlXl2onVb@positron.chronox.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 21. Januar 2018, 23:06:55 CET schrieb Stephan Müller:

Hi Jiri, Dimity, Henrik,

> Hi,
> 
> Changes v3:
> * port to 4.15-rc8
> * small code cleanups (isolation of type casts to functions pertaining
>   to the Apple Magic Trackpad 2
> * clean up all checkpatch.pl errors and warnings (except those
>   where the patch uses the structure of existing code fragments)
> * updated horizontal and vertical limits to capture start of movements
>   in the outer areas of the pad
> 
> ---8<---
> 
> Add support for Apple Magic Trackpad 2 in bcm5974 (MacBook Tochpad) driver.
> The Magic Trackpad 2 needs to be switched into the finger-reporting-mode,
> just like the other macbook touchpads as well. But the format is different
> to the ones before. The Header is 12 Bytes long and each reported finger
> is additional 9 Bytes. The data order reported by the hardware is
> different as well.

May I ask whether there is an issue in the patch? I have not received any 
feedback and would like to inquire about the status of the patch.

I would like to have Touchpad 2 properly supported.

Thanks a lot
Stephan
