Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751451AbeEUJc5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 05:32:57 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50838 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751027AbeEUJcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 05:32:53 -0400
X-Google-Smtp-Source: AB8JxZoVoKFLw6QaOTKF64khmGcg0DZKD8Xz0o5t8oW6K+yxviB27d2H99xTn/Gbr08SOB7DSDiFsg==
Message-ID: <1526895170.2822.3.camel@baylibre.com>
Subject: Re: [PATCH v2 1/2] clk: meson: mpll: add round closest support
From: Jerome Brunet <jbrunet@baylibre.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Mon, 21 May 2018 11:32:50 +0200
In-Reply-To: <CAFBinCCdKgFOod=JimSnBVRvQ8Xmggpa0Uok3rgr3ixB7o+fnA@mail.gmail.com>
References: <20180515163652.19980-1-jbrunet@baylibre.com>
         <20180515163652.19980-2-jbrunet@baylibre.com>
         <CAFBinCCdKgFOod=JimSnBVRvQ8Xmggpa0Uok3rgr3ixB7o+fnA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-05-21 at 11:18 +0200, Martin Blumenstingl wrote:
> On Tue, May 15, 2018 at 6:36 PM, Jerome Brunet <jbrunet@baylibre.com> wrote:
> > Allow the mpll driver to round the requested rate up if
> > CLK_MESON_MPLL_ROUND_CLOSEST is set and it provides a rate closer to the
> > requested rate.
> > 
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> 
> Acked-by: Martin Blumenstingl<martin.blumenstingl@googlemail.com>

Thx for the feedback Martin.
Applied.
