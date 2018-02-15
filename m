Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164107AbeBOVmj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 16:42:39 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:34613 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164015AbeBOVmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 16:42:38 -0500
X-Google-Smtp-Source: AH8x225SKts1FIk+S7fANeZzOUEaCIW9tFxBfRrpXNvl0qJcfVj1hDE3ld1MqDOC+7hONWu2uJ8oBs4iOfqiDMs9ZUk=
MIME-Version: 1.0
In-Reply-To: <20180215201919.GA7076@localhost.localdomain>
References: <CAPVZMnqi0dF1u=Q223trP=mtvYd80Ydp5wamtz3Vt3xhRY-FEQ@mail.gmail.com>
 <20180215201919.GA7076@localhost.localdomain>
From: Julien Durillon <julien@durillon.xyz>
Date: Thu, 15 Feb 2018 22:42:16 +0100
Message-ID: <CAPVZMnp6XbRfmEAU=6GwXO3VswQYr0Jkvwf6qvzPQm0k+pjrOQ@mail.gmail.com>
Subject: Re: [BUG? NVME Linux-4.15] Dracut loops indefinitely with 4.15
To: Keith Busch <keith.busch@intel.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-15 21:19 GMT+01:00 Keith Busch <keith.busch@intel.com>:
> The problem is dracut assumes the 'dev' file for an nvme namespace's
> parent device contains a maj:min for a block device. It's actually a
> character device, and its maj:min happens to also be be the same as the
> device mapper's block device.

So dracut should see that it's a character device and not a block device?

-- 
Julien Durillon
