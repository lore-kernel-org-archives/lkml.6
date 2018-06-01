Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750991AbeFAUyx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 16:54:53 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:45273 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750776AbeFAUyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 16:54:49 -0400
X-Google-Smtp-Source: ADUXVKJgD7W0cwSjwfEwGdI+eAhy1j63dQBXc6NruChGI/HWySaAtVVqoTHAZO29hYGgzZq+4JO0NIkwFK3S2JZAnKk=
MIME-Version: 1.0
In-Reply-To: <20180601202016.169085-1-ksspiers@google.com>
References: <20180601202016.169085-1-ksspiers@google.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 1 Jun 2018 13:54:48 -0700
Message-ID: <CAPcyv4gOhnEcJuZZwCoZyMuLsA65Q0EMx1y94xMyRCySv8XcQw@mail.gmail.com>
Subject: Re: [PATCH v3] async_pq: Remove VLA usage
To: Kyle Spiers <ksspiers@google.com>
Cc: David Miller <davem@davemloft.net>, Kees Cook <keescook@chromium.org>,
        ray.jui@broadcom.com, vkoul@kernel.org,
        linux-crypto <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 1, 2018 at 1:20 PM, Kyle Spiers <ksspiers@google.com> wrote:
> In the quest to remove VLAs from the kernel[1], this adjusts the
> allocation of coefs and blocks to use the existing maximum values
> (with one new define, MAX_DISKS for coefs, and a reuse of the
> existing NDISKS for blocks).
>
> [1] https://lkml.org/lkml/2018/3/7/621
>
> Signed-off-by: Kyle Spiers <ksspiers@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Vinod, will you have a chance to pick this and carry through dmaengine.git?
