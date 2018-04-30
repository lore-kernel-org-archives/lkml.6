Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756311AbeD3TpH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 15:45:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932353AbeD3TpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 15:45:04 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 914F622B32
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AB8JxZrJ20XJWrQA6PfnWMBpnT1k/+sV1Eoe5NjaxAWjb/gVunQyg4AohlyOW/7n8pfvOB72zQzHp79Odv0iA7uH4JY=
MIME-Version: 1.0
In-Reply-To: <20180430181058.30181-2-eric@anholt.net>
References: <20180430181058.30181-1-eric@anholt.net> <20180430181058.30181-2-eric@anholt.net>
From: Rob Herring <robh@kernel.org>
Date: Mon, 30 Apr 2018 14:44:41 -0500
X-Gmail-Original-Message-ID: <CABGGisywpJr14yBDcgLEm46hJOCkJO1PROH-acfDJBR69T0prw@mail.gmail.com>
Message-ID: <CABGGisywpJr14yBDcgLEm46hJOCkJO1PROH-acfDJBR69T0prw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: Add a new binding for Broadcom V3D
 3.x and newer GPUs.
To: Eric Anholt <eric@anholt.net>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 1:10 PM, Eric Anholt <eric@anholt.net> wrote:
> These OpenGL ES GPUs are present in the 7268 and 7278 set top box
> chips.
>
> v2: no changes
> v3: move to gpu/, fix typo
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  .../devicetree/bindings/gpu/brcm,bcm-v3d.txt  | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpu/brcm,bcm-v3d.txt

Reviewed-by: Rob Herring <robh@kernel.org>
