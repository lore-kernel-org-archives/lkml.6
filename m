Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752100AbeEQXSV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 19:18:21 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:12763 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbeEQXST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 19:18:19 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180517231818epoutp02798faf9fdfe2c34bad687169f6c06619~vkcqZMuK_0580205802epoutp02J
X-AuditID: b6c32a35-9cbff70000001024-63-5afe0db72cfb
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Message-id: <5AFE0DB6.1060801@samsung.com>
Date: Fri, 18 May 2018 08:18:14 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Matthias Kaehlcke <mka@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] PM / devfreq: Remove redundant frequency adjustment
 from governors
In-reply-to: <20180517224126.GP19594@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAKsWRmVeSWpSXmKPExsWy7bCmvu523n9RBi19KhabPr5ntTi77CCb
        xdmmN+wWl3fNYbP43HuE0eLzhseMFrcbV7A5sHvMbrjI4tG3ZRWjx+dNcgHMUak2GamJKalF
        Cql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUDLlRTKEnNKgUIBicXF
        Svp2NkX5pSWpChn5xSW2StGGhkZ6hgbmekZGQNo41srIFKgkITVj45FzrAV3+CqO9B9hbWBs
        4uli5OSQEDCRWDZjA2sXIxeHkMAORon3c/qYIZzvjBJNv64xdTFygFXNuyUN0iAksJtRYk2T
        AojNKyAo8WPyPRaQEmYBeYkjl7JBwswCmhIvvkxigRhzl1Fi85v/TBD1WhKXNu9iBLFZBFQl
        5j7fDGazAcX3v7jBBmLzCyhKXP3xGCwuKhAhsXP+N3aQ+SICdRIrvtSDzGQW6GeU2Ni4iBWk
        RlggUmLVn8VgvZwCBhIrjvaDPSMhcIBNYkXDcRaIL10kHl87xARhC0u8Or6FHeIvaYlLR20h
        6tsZJdr3zmOGcKYwSpy7fg+qwVji2cIuJojX+CTefe1hhWjmlehoE4Io8ZC4tmESG4TtKHHh
        1itoiK5nlFg6+Rr7BEa5WUgBNgsRYLOQAmwBI/MqRrHUguLc9NRiwwJDveLE3OLSvHS95Pzc
        TYzg1KZluoNxyjmfQ4wCHIxKPLwT+v9GCbEmlhVX5h5ilOBgVhLh9asECvGmJFZWpRblxxeV
        5qQWH2I0BYb3RGYp0eR8YNrNK4k3NDUyNja2MDE0MzU0VBLnnaP0NUpIID2xJDU7NbUgtQim
        j4mDU6qBsfT0x/9dt/ikV2nd//I59vfOS7k3Fda3Fnm4ygQ983j79LLnVF5rlf7lm2zVtzRN
        f8n9gUVX318s4ZTuyiOPxSb8LUgoNiz9LSg7cW3JUovfx88+8b5rdlpyoqJjfP6DOq8rFzgy
        q77KPyybVLci5l7S3Xond2/nVzZvFcuWvYnjfWF/2znmrRJLcUaioRZzUXEiAF7OTkODAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsVy+t9jAd1tvP+iDBZOMbHY9PE9q8XZZQfZ
        LM42vWG3uLxrDpvF594jjBafNzxmtLjduILNgd1jdsNFFo++LasYPT5vkgtgjuKySUnNySxL
        LdK3S+DK2HjkHGvBHb6KI/1HWBsYm3i6GDk4JARMJObdku5i5OIQEtjJKLF3TQ9TFyMnB6+A
        oMSPyfdYQGqYBeQljlzKhjDVJaZMyYUov88o8WjLdqhyLYlLm3cxgtgsAqoSc59vBrPZgOL7
        X9xgA7H5BRQlrv54zAgyR1QgQqL7RCXIHBGBBkaJxlez2UAcZoGJjBJXV91jBWkQFoiUuHVz
        NTPEtvWMErv6loIlOAUMJFYc7WedwCgwC8mtsxBunYVw6wJG5lWMkqkFxbnpucVGBYZ5qeV6
        xYm5xaV56XrJ+bmbGIFBve2wVt8OxvtL4g8xCnAwKvHwvpj4N0qINbGsuDL3EKMEB7OSCK9f
        JVCINyWxsiq1KD++qDQntfgQozQHi5I47+28Y5FCAumJJanZqakFqUUwWSYOTqkGRpMH/8Uy
        jf+t3J14dtIXroUHPncWH2XsLFktGnjquPacRyJJdq2BeiZljQYuwjvm/lNfdU2kQP7H+vD+
        pEer/K1+2n37rrz+xO/dVSc27ZsfmZa0NfpL1Ypbgq2PVKeeecW0956GhprY5YkOR25rvk5j
        UrVIl2+0UXGUrPvgvf6nBe/F0C+7JiixFGckGmoxFxUnAgAd1TfwZgIAAA==
X-CMS-MailID: 20180517231815epcas1p1d5988d780ebe35314b973d79c50656cb
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180517224139epcas4p4c62c83cad84b5f1e81d16a215306ea0e
X-RootMTR: 20180517224139epcas4p4c62c83cad84b5f1e81d16a215306ea0e
References: <20180516211051.78875-1-mka@chromium.org>
        <CGME20180517224139epcas4p4c62c83cad84b5f1e81d16a215306ea0e@epcas4p4.samsung.com>
        <20180517224126.GP19594@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018년 05월 18일 07:41, Matthias Kaehlcke wrote:
> On Wed, May 16, 2018 at 02:10:51PM -0700, Matthias Kaehlcke wrote:
>> The performance, powersave, simpleondemand and userspace governors
>> determine a target frequency and then adjust it according to the
>> df->min/max_freq limits that might have been set by user space. This
>> adjustment is redundant, it is done in update_devfreq() for any
>> governor, right after governor->get_target_freq().
>>
>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>> ---
>>  drivers/devfreq/governor_performance.c    | 10 ++--------
>>  drivers/devfreq/governor_powersave.c      |  5 -----
>>  drivers/devfreq/governor_simpleondemand.c |  7 +------
>>  drivers/devfreq/governor_userspace.c      | 16 ++++------------
>>  4 files changed, 7 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/devfreq/governor_performance.c b/drivers/devfreq/governor_performance.c
>> index 4d23ecfbd948..31ee30622c00 100644
>> --- a/drivers/devfreq/governor_performance.c
>> +++ b/drivers/devfreq/governor_performance.c
>> @@ -16,14 +16,8 @@
>>  static int devfreq_performance_func(struct devfreq *df,
>>  				    unsigned long *freq)
>>  {
>> -	/*
>> -	 * target callback should be able to get floor value as
>> -	 * said in devfreq.h
>> -	 */
>> -	if (!df->max_freq)
>> -		*freq = UINT_MAX;
>> -	else
>> -		*freq = df->max_freq;
>> +	*freq = UINT_MAX;
>> +
>>  	return 0;
>>  }
> 
> For the record, the frequency adjustment in update_devfreq() is
> currently broken for df->max_freq == 0:
> 
> https://patchwork.kernel.org/patch/10407827/

Why don't you send patch set? It is very difficult to track
the history and a correlation between patches. Usually, if patches
have the dependency between patches, send the patch set with cover-letter.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
