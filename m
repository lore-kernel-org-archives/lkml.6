Return-Path: <xieyisheng1@huawei.com>
X-Google-Smtp-Source: AH8x226Ilo9idi20Mihs1q21FB/aldDqOrR6fWdquetkhxfIkwWfxhRRHqFOIy6YsCo+4kHoC06C
ARC-Seal: i=1; a=rsa-sha256; t=1518435259; cv=none;
        d=google.com; s=arc-20160816;
        b=dv8X9pIxmvpjsrqzdaw2CBgEHbACAcO4GPr/lTMne3w68yDgyEwSqaVQfgsTnadlDf
         8sEfp4beqEygRsVQhL2kI7CyZ87KRzCe2DZFraz9T31MOC1SvCixaP1tojxJAkP5BNyP
         LFvsEvDezodkbx9Xdhzpb1GpPBD9SF6hYMFSb3MOYZxfxhngz6NvQZZDmqk55LPKmVQw
         y4ktjLjKSI/qnpes7eMzDAxuxnzS5IC+vnycr8uKDojKCyhiQV7vmyY5Czc9y/oMkmFu
         Qfsuh20eRFdmra5RrC+zbLyaKJAsX7/OUj9uu26MASQIdME2FDGQHJU/xp0yl/RfZ2Aw
         oQBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=99+0d+Vk3Ev1d1HPjYFsKW0k8wrm+QGjJ4rBf+tCR3k=;
        b=gvftWO/71xLomxl/aTaNjiLlb+oO2u9mWoTc0gF7yMVp/6ej8o/je6UKyFfnewqED1
         6yJrsi3jrYniZkzDfjIc8XFXRBJUXWtbJnYn80AOV1McayitaN7FngqvaLiUbeq4s9Sd
         OiyUgJPYJXn5VkU5GgAcCmPs/1gzNXD2G2Hc+lOWPlPygUTN3+FBxcK6FdHtQ4jXeyT0
         2P/6o3W3JIM3D7SFHW/KAWRRiCIjqQOHVowhdtozVb2KTb4M09St8H6OkJEK/cJ3HkeT
         si3bjygX2LUvE5l8W2phT9Cbc1KuYbMMvYMc+I64SL3r/Z2OHvzCMVmxChUo2XxgnESM
         X6Ng==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of xieyisheng1@huawei.com designates 45.249.212.32 as permitted sender) smtp.mailfrom=xieyisheng1@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of xieyisheng1@huawei.com designates 45.249.212.32 as permitted sender) smtp.mailfrom=xieyisheng1@huawei.com
Subject: Re: [PATCH v2 0/9] staging: android: ion: Some cleanup about ion
To: Dan Carpenter <dan.carpenter@oracle.com>
References: <1518432194-41536-1-git-send-email-xieyisheng1@huawei.com>
 <20180212111710.zc2eskdu5dvlvww4@mwanda>
CC: <gregkh@linuxfoundation.org>, <labbott@redhat.com>,
	<sumit.semwal@linaro.org>, <devel@driverdev.osuosl.org>,
	<linux-kernel@vger.kernel.org>
From: Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <189b2f7b-4348-1ebc-fb9b-7e7588824cf1@huawei.com>
Date: Mon, 12 Feb 2018 19:33:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <20180212111710.zc2eskdu5dvlvww4@mwanda>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.40]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592192143298654950?=
X-GMAIL-MSGID: =?utf-8?q?1592194770604150331?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Dan,

On 2018/2/12 19:17, Dan Carpenter wrote:
> On Mon, Feb 12, 2018 at 06:43:05PM +0800, Yisheng Xie wrote:
>> Hi all,
>>
>> When I tried to review the code of ion, I find that there are many place
>> can be cleanup, so I post this patchset.
>>
>> I mark it as v2, because I have post them in different patchset before[1][2]
>> [3][4]. And now, I combine them in one patchset to make it easy to review,
>> Meanwhile, I add some acks and rebase them to v4.15-rc1.
>>
>> Thanks.
>>
>> [1] https://lkml.org/lkml/2018/1/31/711
>> [2] https://lkml.org/lkml/2018/2/1/240
>> [3] https://lkml.org/lkml/2018/2/4/320
>> [4] https://lkml.org/lkml/2018/2/6/949
>>
> 
> Could you go back and reply to these threads that you have redone the
> patches?  Otherwise, what's likely to happen is that Greg will apply
> as many as he can get to this series and it won't apply.

Sure! thanks

Yisheng
> 
> regards,
> dan carpenter
> 
> 
> 
