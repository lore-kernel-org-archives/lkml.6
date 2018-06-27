Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E02C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 01:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD8D126A39
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 01:51:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD8D126A39
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lge.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753236AbeF0BvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 21:51:12 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:54819 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751065AbeF0BvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 21:51:10 -0400
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
        by 156.147.23.51 with ESMTP; 27 Jun 2018 10:51:08 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO ?10.177.222.33?) (10.177.222.33)
        by 156.147.1.151 with ESMTP; 27 Jun 2018 10:51:08 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Subject: Re: [PATCH] locking/memory-barriers.txt/kokr: Update Korean
 translation to fix broken DMA vs. MMIO ordering example
To:     SeongJae Park <sj38.park@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc:     linux-doc <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, kernel-team@lge.com
References: <20180617051608.2128-1-sj38.park@gmail.com>
 <20180626004738.GA20783@X58A-UD3R> <alpine.DEB.2.20.1806261218490.1528@hxeon>
 <20180626045609.GB20783@X58A-UD3R> <alpine.DEB.2.20.1806261406220.1528@hxeon>
 <20180626065827.GC20783@X58A-UD3R> <20180626122242.GX3593@linux.vnet.ibm.com>
 <CAEjAshpv13xoZ7m6=vX=3o+iUQEG7ExCg8BpPDpOY5ZW3+gxQA@mail.gmail.com>
 <20180626220649.GN3593@linux.vnet.ibm.com>
 <CAEjAshoQedrCzQmSDV-0tnmUPPa8s6QbpYepgMrN7q-SZGLC+g@mail.gmail.com>
From:   Byungchul Park <byungchul.park@lge.com>
Message-ID: <8075c23e-ce8e-4573-a289-e651391745d4@lge.com>
Date:   Wed, 27 Jun 2018 10:51:00 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAEjAshoQedrCzQmSDV-0tnmUPPa8s6QbpYepgMrN7q-SZGLC+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/27/2018 07:43 AM, SeongJae Park wrote:
> On Wed, Jun 27, 2018 at 7:04 AM Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
>> On Tue, Jun 26, 2018 at 09:25:08PM +0900, SeongJae Park wrote:
>>> Hello Paul,
>>>
>>> On Tue, Jun 26, 2018 at 9:20 PM Paul E. McKenney
>>> <paulmck@linux.vnet.ibm.com> wrote:
>>>> On Tue, Jun 26, 2018 at 03:58:27PM +0900, Byungchul Park wrote:
>>>>> On Tue, Jun 26, 2018 at 02:10:17PM +0900, SeongJae Park wrote:
>>>>>>
>>>>>> On Tue, 26 Jun 2018, Byungchul Park wrote:
>>>>>>
>>>>>>> On Tue, Jun 26, 2018 at 12:21:23PM +0900, sjpark wrote:
>>>>>>>> Hello Byungchul,
>>>>>>>>
>>>>>>>>
>>>>>>>> On Tue, 26 Jun 2018, Byungchul Park wrote:
>>>>>>>>
>>>>>>>>> On Sun, Jun 17, 2018 at 02:16:08PM +0900, SeongJae Park wrote:
>>>>>>>>>> Translate this commit to Korean:
>>>>>>>>>>
>>>>>>>>>>    5846581e3563 ("locking/memory-barriers.txt: Fix broken DMA vs. MMIO ordering example")
>>>>>>>>> Hi SeongJae,
>>>>>>>>>
>>>>>>>>> You keep doing good jobs ;)
>>>>>>>>>
>>>>>>>>> I believe it would be better if you consider the little things below
>>>>>>>>> more. What do you think about it, SeongJae?
>>>>>>>> Thank you for great comments!
>>>>>>>>
>>>>>>>>>> Signed-off-by: SeongJae Park <sj38.park@gmail.com>
>>>>>>>>>> ---
>>>>>>>>>>   Documentation/translations/ko_KR/memory-barriers.txt | 15 +++++++--------
>>>>>>>>>>   1 file changed, 7 insertions(+), 8 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
>>>>>>>>>> index 921739d00f69..ada0a709cce1 100644
>>>>>>>>>> --- a/Documentation/translations/ko_KR/memory-barriers.txt
>>>>>>>>>> +++ b/Documentation/translations/ko_KR/memory-barriers.txt
>>>>>>>>>> @@ -1891,19 +1891,18 @@ Mandatory 배리어들은 SMP 시스템에서도 UP 시스템에서도 SMP 효
>>>>>>>>>>              /* 소유권을 수정 */
>>>>>>>>>>              desc->status = DEVICE_OWN;
>>>>>>>>>>
>>>>>>>>>> -           /* MMIO 를 통해 디바이스에 공지를 하기 전에 메모리를 동기화 */
>>>>>>>>>> -           wmb();
>>>>>>>>>> -
>>>>>>>>>>              /* 업데이트된 디스크립터의 디바이스에 공지 */
>>>>>>>>>>              writel(DESC_NOTIFY, doorbell);
>>>>>>>>>>      }
>>>>>>>>>>
>>>>>>>>>>        dma_rmb() 는 디스크립터로부터 데이터를 읽어오기 전에 디바이스가 소유권을
>>>>>>>>>> -     내놓았음을 보장하게 하고, dma_wmb() 는 디바이스가 자신이 소유권을 다시
>>>>>>>>>> -     가졌음을 보기 전에 디스크립터에 데이터가 쓰였음을 보장합니다.  wmb() 는
>>>>>>>>>> -     캐시 일관성이 없는 (cache incoherent) MMIO 영역에 쓰기를 시도하기 전에
>>>>>>>>>> -     캐시 일관성이 있는 메모리 (cache coherent memory) 쓰기가 완료되었음을
>>>>>>>>>> -     보장해주기 위해 필요합니다.
>>>>>>>>>> +     내려놓았을 것을 보장하고, dma_wmb() 는 디바이스가 자신이 소유권을 다시
>>>>>>>>>> +     가졌음을 보기 전에 디스크립터에 데이터가 쓰였을 것을 보장합니다.  writel()
>>>>>>>>>                                                                          ^
>>>>>>>>>                                                                       참고로,
>>>>>>>> Nice comment.  This will enhance the readability a lot.
>>>>>>> Could you add this, too? A quite little thing tho.
>>>>>> Oops, I missed that.  Sorry.  Attaching the patch below.
>>>>>>
>>>>>>
>>>>>> Thanks, SeongJae Park
>>>>> Thanks a lot, SeongJae.
>>>>>
>>>>> Acked-by: Byungchul Park <byungchul.park@lge.com>
>>>> Thank you both!
>>>>
>>>> The patch below is the complete patch, so that I should replace
>>>> what I have with it, correct?  If not, please help me out here.  ;-)
>>> Yes, correct! :)
>> Like this, then?
> Yes, of course ;)

Yes~

>
>
> Thanks,
> SeongJae Park
>
>>                                                          Thanx, Paul
>>
>> ------------------------------------------------------------------------
>>
>> commit 3cb0d7701c4ce6668fb5096c90ec6d5b4bf71638
>> Author: SeongJae Park <sj38.park@gmail.com>
>> Date:   Sun Jun 17 14:16:08 2018 +0900
>>
>>      locking/memory-barriers.txt/kokr: Update Korean translation to fix broken DMA vs. MMIO ordering example
>>
>>      Translate this commit to Korean:
>>
>>        5846581e3563 ("locking/memory-barriers.txt: Fix broken DMA vs. MMIO ordering example")
>>
>>      Signed-off-by: SeongJae Park <sj38.park@gmail.com>
>>      Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>>      [ paulmck: Updated based on feedback from Byungchul Park. ]
>>      Acked-by: Byungchul Park <byungchul.park@lge.com>
>>
>> diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
>> index 921739d00f69..7f01fb1c1084 100644
>> --- a/Documentation/translations/ko_KR/memory-barriers.txt
>> +++ b/Documentation/translations/ko_KR/memory-barriers.txt
>> @@ -1891,22 +1891,22 @@ Mandatory 배리어들은 SMP 시스템에서도 UP 시스템에서도 SMP 효
>>                  /* 소유권을 수정 */
>>                  desc->status = DEVICE_OWN;
>>
>> -               /* MMIO 를 통해 디바이스에 공지를 하기 전에 메모리를 동기화 */
>> -               wmb();
>> -
>>                  /* 업데이트된 디스크립터의 디바이스에 공지 */
>>                  writel(DESC_NOTIFY, doorbell);
>>          }
>>
>>        dma_rmb() 는 디스크립터로부터 데이터를 읽어오기 전에 디바이스가 소유권을
>> -     내놓았음을 보장하게 하고, dma_wmb() 는 디바이스가 자신이 소유권을 다시
>> -     가졌음을 보기 전에 디스크립터에 데이터가 쓰였음을 보장합니다.  wmb() 는
>> -     캐시 일관성이 없는 (cache incoherent) MMIO 영역에 쓰기를 시도하기 전에
>> -     캐시 일관성이 있는 메모리 (cache coherent memory) 쓰기가 완료되었음을
>> -     보장해주기 위해 필요합니다.
>> -
>> -     consistent memory 에 대한 자세한 내용을 위해선 Documentation/DMA-API.txt
>> -     문서를 참고하세요.
>> +     내려놓았을 것을 보장하고, dma_wmb() 는 디바이스가 자신이 소유권을 다시
>> +     가졌음을 보기 전에 디스크립터에 데이터가 쓰였을 것을 보장합니다.  참고로,
>> +     writel() 을 사용하면 캐시 일관성이 있는 메모리 (cache coherent memory)
>> +     쓰기가 MMIO 영역에의 쓰기 전에 완료되었을 것을 보장하므로 writel() 앞에
>> +     wmb() 를 실행할 필요가 없음을 알아두시기 바랍니다.  writel() 보다 비용이
>> +     저렴한 writel_relaxed() 는 이런 보장을 제공하지 않으므로 여기선 사용되지
>> +     않아야 합니다.
>> +
>> +     writel_relaxed() 와 같은 완화된 I/O 접근자들에 대한 자세한 내용을 위해서는
>> +     "커널 I/O 배리어의 효과" 섹션을, consistent memory 에 대한 자세한 내용을
>> +     위해선 Documentation/DMA-API.txt 문서를 참고하세요.
>>
>>
>>   MMIO 쓰기 배리어
>>

