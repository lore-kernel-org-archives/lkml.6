Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04F1C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFA51206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ISdJXlpW";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SGYYU0Q0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbfBRJHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 04:07:45 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:37362 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729382AbfBRJHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 04:07:44 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F07C760918; Mon, 18 Feb 2019 09:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550480864;
        bh=xy9Kzyrvl55Y25+B1JpxddE1RYYUzSTA0hxNqVaYljI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ISdJXlpWm73ORN+tAj7eliOtAcJ2tdzZ71z93zvurPLG4xire2NHpWfQonKkw4w9F
         c1vHneNlx1DRk6K9Jl8F9Gv9AhAG4hVETfolYl2K3R/CYDgjEnz9S8l9hlw9kSHTy9
         29tWY+8n6DSTgdV86Y3Em46+jDBjG8++XfGZCYek=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id EC687601D4;
        Mon, 18 Feb 2019 09:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550480862;
        bh=xy9Kzyrvl55Y25+B1JpxddE1RYYUzSTA0hxNqVaYljI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SGYYU0Q0VHEmmAsJnsdaYWy3rRo9q9GWmC+TwrRl6F5rHvkBPvKwjE7UuMBjvmrrR
         +R0c4Bo1Y1ZMY2gTDwb7Qe/kXJ2x2aY9ObvX00903WDqjqfICdGXxfgx6TeG5ZEznh
         bBDXtn+lm9jcAolu/v37QSSmea0Yf/aA5r6/Nnf0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 18 Feb 2019 14:37:41 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Nicolas Dechesne <nicolas.dechesne@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, Josh Boyer <jwboyer@kernel.org>,
        Linux Firmware <linux-firmware@kernel.org>,
        BlueZ development <linux-bluetooth@vger.kernel.org>,
        Hemantg <hemantg@codeaurora.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Linux-arm Msm <linux-arm-msm@vger.kernel.org>
Subject: Re: Firmware files for QCA BT chip WCN3990.
In-Reply-To: <CAP71WjzHFD0LGjgZxkb_Pix=z3KViNdt_m6CvTdWqSoz_cLFyg@mail.gmail.com>
References: <795c3942482d96c696b4368e68de1ba0@codeaurora.org>
 <CAP71WjzHFD0LGjgZxkb_Pix=z3KViNdt_m6CvTdWqSoz_cLFyg@mail.gmail.com>
Message-ID: <5d479f9f60301a5939340e4ba9d23646@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi Nicolas,


On 2019-02-18 14:08, Nicolas Dechesne wrote:
> hi Balakrishna,
> 
> On Mon, Feb 18, 2019 at 7:13 AM Balakrishna Godavarthi
> <bgodavar@codeaurora.org> wrote:
>> 
>> 
>> Hi,
>> 
>> The following changes since commit
>> a9c22d3d8af87bd39a078ec6c846b0674dd2ca38:
>> 
>>    qca: Add firmware files for BT chip wcn3990. (2019-02-15 16:07:56
>> +0530)
>> 
>> are available in the Git repository at:
>> 
>>    https://github.com/bgodavar/qca_bt_wcn3990_fw.git
>> 
>> for you to fetch changes up to 
>> a9c22d3d8af87bd39a078ec6c846b0674dd2ca38:
>> 
>>    qca: Add firmware files for BT chip wcn3990. (2019-02-15 16:07:56
>> +0530)
> 
>  qca/NOTICE.txt   | 334
> ++++++++++++++++++++++++++++++++++--------------------------------------------------------
> 
> ^ This looks a rather unexpected change.

[Bala]: yes we want to update the notice file according to the latest 
legal rules here in QCA.

> 
> You are missing updates in WHENCE file, as such:
> 
> $ make check
> E: qca/crbtfw21.tlv not listed in WHENCE
> E: qca/crnv21.bin not listed in WHENCE

[Bala]: will update them in WHENCE.

>> 
>> 
>> --
>> Regards
>> Balakrishna.

-- 
Regards
Balakrishna.
