Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755371AbeDCK2I (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 06:28:08 -0400
Received: from smtp62.i.mail.ru ([217.69.128.42]:36208 "EHLO smtp62.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754827AbeDCK2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 06:28:06 -0400
Subject: Re: [PATCH 5/6] spi: sun4i: introduce register set/unset helpers
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org
References: <20180329185907.27281-1-ssuloev@orpaltech.com>
 <20180329185907.27281-6-ssuloev@orpaltech.com>
 <20180403081458.lyilg3yu3n2e54fd@flea>
From: Sergey Suloev <ssuloev@orpaltech.com>
Message-ID: <8edccc63-9729-ff4c-b272-1916e7794bc7@orpaltech.com>
Date: Tue, 3 Apr 2018 13:27:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180403081458.lyilg3yu3n2e54fd@flea>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Authentication-Results: smtp62.i.mail.ru; auth=pass smtp.auth=ssuloev@orpaltech.com smtp.mailfrom=ssuloev@orpaltech.com
X-7FA49CB5: 0D63561A33F958A5247FC1B526A057B5AB1DA08539F67DF37649B479DD24E3CA725E5C173C3A84C30584FF81F342DA079C2F722F016DF63EB7122A4C44A4E42FC4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F5D41B9178041F3E72623479134186CDE6BA297DBC24807EABDAD6C7F3747799A
X-Mailru-Sender: C5364AD02485212F3ACDC11E67D84917E12ECED5A0CEE34B7BF1F2511D8B6519069BFC61DABEEB110841D3AAAB1726C63DDE9B364B0DF289264D2CD8C2503E8C22A194DADEED8EEDCA01A23BA9CD1BE7ED14614B50AE0675
X-Mras: OK
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2018 11:14 AM, Maxime Ripard wrote:
> On Thu, Mar 29, 2018 at 09:59:06PM +0300, Sergey Suloev wrote:
>> Two helper functions were added in order to update
>> registers easily.
>>
>> Signed-off-by: Sergey Suloev <ssuloev@orpaltech.com>
> I'm not really sure what's easier about this one.
>
> Maxime
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

well, just seems more readable vs doing "read, or, write" every time
