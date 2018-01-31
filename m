Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932306AbeAaAdf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 19:33:35 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:32847 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932288AbeAaAde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 19:33:34 -0500
X-Google-Smtp-Source: AH8x226TSFVue1qUZ6vzhsjjVvDOpTTd24P/eQsnX4q6M0KSEVn3RNFBfGqZ1wA4SNU0R4UUT0dlFw==
From: Kevin Hilman <khilman@baylibre.com>
To: Jorge Ramirez-Ortiz <jramirez@baylibre.com>
Cc: carlo@caione.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, jbrunet@baylibre.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM64: dts: meson: accept MAC addr from u-boot  environment
Organization: BayLibre
References: <1516186587-22157-1-git-send-email-jramirez@baylibre.com>
Date: Tue, 30 Jan 2018 16:33:28 -0800
In-Reply-To: <1516186587-22157-1-git-send-email-jramirez@baylibre.com> (Jorge
        Ramirez-Ortiz's message of "Wed, 17 Jan 2018 11:56:27 +0100")
Message-ID: <7hd11qc1ev.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jorge Ramirez-Ortiz <jramirez@baylibre.com> writes:

> Extend configuring the MAC address from u-boot to all meson boards.
>
> I didn't test this changeset but having checked libretech's u-boot
> tree I believe it should just work.
>
> Signed-off-by: Jorge Ramirez-Ortiz <jramirez@baylibre.com>

Applied for v4.17, let's see we find any breakage in linux-next,

Kevin
