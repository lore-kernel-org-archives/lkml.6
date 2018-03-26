Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752771AbeCZWY6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 18:24:58 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:40189 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752734AbeCZWYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 18:24:49 -0400
X-Google-Smtp-Source: AG47ELs0Y9pHX4l1KKH6/FsuvOydXv7LxmQXf5FFrKoKS9BMi37h6KbwfP/YLxfTarJEX07mq21+LQ==
Date: Mon, 26 Mar 2018 17:24:46 -0500
From: Rob Herring <robh@kernel.org>
To: Tirupathi Reddy <tirupath@codeaurora.org>
Cc: dmitry.torokhov@gmail.com, bjorn.andersson@linaro.org,
        mark.rutland@arm.com, linux-input@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] Input: pm8941-pwrkey: add resin key capabilities
Message-ID: <20180326222446.spjzqqgiujadd3zm@rob-hp-laptop>
References: <1521786192-19487-1-git-send-email-tirupath@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521786192-19487-1-git-send-email-tirupath@codeaurora.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 11:53:12AM +0530, Tirupathi Reddy wrote:
> Add resin key support to handle different types of key events
> defined in different platforms.
> 
> Signed-off-by: Tirupathi Reddy <tirupath@codeaurora.org>
> ---
>  .../bindings/input/qcom,pm8941-pwrkey.txt          | 32 +++++++++

Reviewed-by: Rob Herring <robh@kernel.org>

>  drivers/input/misc/pm8941-pwrkey.c                 | 81 ++++++++++++++++++++++
>  2 files changed, 113 insertions(+)
