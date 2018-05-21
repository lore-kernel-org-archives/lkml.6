Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751645AbeEUJdc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 05:33:32 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33395 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751109AbeEUJd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 05:33:27 -0400
X-Google-Smtp-Source: AB8JxZq7fx8XNk/tFlcMLSGt37xo8z1hFdR8nEL5pgWUBk7ujOIP9ZFo2Lb3BOLlluoBBExRQBSWxQ==
Message-ID: <1526895204.2822.4.camel@baylibre.com>
Subject: Re: [PATCH v2 2/2] clk: meson: axg: let mpll clocks round closest
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Mon, 21 May 2018 11:33:24 +0200
In-Reply-To: <61fa49ae-e73e-957e-e28a-134102f82194@baylibre.com>
References: <20180515163652.19980-1-jbrunet@baylibre.com>
         <20180515163652.19980-3-jbrunet@baylibre.com>
         <61fa49ae-e73e-957e-e28a-134102f82194@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-05-15 at 18:46 +0200, Neil Armstrong wrote:
> On 15/05/2018 18:36, Jerome Brunet wrote:
> > Let the mpll dividers achieve the closest rate possible, even if
> > it means rounding the requested rate up.
> > 
> > This is done to improve the accuracy of the rates provided by these
> > plls to the audio subsystem
> > 
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > ---
> > 
[...]
> 
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Applied
