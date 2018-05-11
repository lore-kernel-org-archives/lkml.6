Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751859AbeEKPzs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 11:55:48 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:54316 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbeEKPzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 11:55:46 -0400
X-Google-Smtp-Source: AB8JxZr9+DRIqLQbVVZmy+6TzY7uYkj/n9NR1HkutFrmFM4VxzXIACc9u6wvoM5W5+BfQ9oDALnC6c0mUnOEBMhYjqg=
MIME-Version: 1.0
In-Reply-To: <c43fc92fb85f9568ee09de6c7c1a46745e012355.1525447375.git-series.maxime.ripard@bootlin.com>
References: <cover.0c9a2cb0b38deb7304c60c507f45cf50352b752a.1525447375.git-series.maxime.ripard@bootlin.com>
 <c43fc92fb85f9568ee09de6c7c1a46745e012355.1525447375.git-series.maxime.ripard@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 May 2018 17:55:45 +0200
Message-ID: <CACRpkdZ6-fZ=QN3MtvMyWKvo2um5HVMYPRdFbtLyg0JP40aYbg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: panel: Add the Ilitek ILI9881c panel documentation
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 4, 2018 at 5:23 PM, Maxime Ripard <maxime.ripard@bootlin.com> wrote:

> The LHR050H41 from BananaPi is a 1280x700 4-lanes DSI panel based on the
> ILI9881c from Ilitek.
>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
(...)

Bah, now I see this:

> +  - power-gpios: a GPIO phandle for the power pin

That should probably be a fixed regulator backed by a GPIO
instead. Especially if you know which voltage it has. So
one more layer of abstraction, sorry.

Yours,
Linus Walleij
