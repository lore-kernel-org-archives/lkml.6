Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id mYfIGTXFG1trGwAAmS7hNA
	; Sat, 09 Jun 2018 12:16:53 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4E1DB6089E; Sat,  9 Jun 2018 12:16:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id AB50A606FA;
	Sat,  9 Jun 2018 12:16:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AB50A606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753227AbeFIMQt (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 08:16:49 -0400
Received: from pindarots.xs4all.nl ([82.161.210.87]:52316 "EHLO
        pindarots.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752979AbeFIMQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 08:16:48 -0400
Received: from surfplank2.hierzo (localhost.localdomain [127.0.0.1])
        by pindarots.xs4all.nl (8.15.2/8.14.5) with ESMTPS id w59CGkUf019276
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
        for <linux-kernel@vger.kernel.org>; Sat, 9 Jun 2018 14:16:47 +0200
Subject: Re: 4.16.14: kernel tried to execute NX-protected page [after USB
 device went to charging state]
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <12230457-6839-c320-c270-be4916486438@xs4all.nl>
From: Udo van den Heuvel <udovdh@xs4all.nl>
Organization: hierzo
Message-ID: <5ba4279b-0df3-c5b2-86ac-b72fcff60c9b@xs4all.nl>
Date: Sat, 9 Jun 2018 14:16:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <12230457-6839-c320-c270-be4916486438@xs4all.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-06-18 11:50, Udo van den Heuvel wrote:
> My Holux GPSport 245 was used to download a gpx track. Afterwards I 
> turned the device off while it was attached to USB so it could charge.
> Later I found these messages you can find below.

Actually I removed the charging Holux GPSport from the USB cable and 
then the Oops appears.
I could reproduce this a minute ago.

Udo
