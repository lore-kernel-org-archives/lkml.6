Return-Path: <leo.wen@rock-chips.com>
X-Google-Smtp-Source: AG47ELsM5txTJq++WLzxp8WSuwR+4dDbNEVTEvFlZTJq0DfPbSYpUPvIORDU/EVy0/KvxYZ/mpyl
ARC-Seal: i=1; a=rsa-sha256; t=1520424156; cv=none;
        d=google.com; s=arc-20160816;
        b=G2PubPVH1LEZfz/dLdGQGyp5b4BvBYvwmunbzpaFyZcs9ngBEJ6fPLfHTPZmbDNXST
         W/0d0/d/U5VRmanvDa/N84dz+2aNA7u15L0/hfujEfSMzRpE0ATfzncxqfhVDxv010ty
         BzrFdQ/jHWqifbRFNn4gZA10qN1q+K5ZVqcCRCYKxUkYXOGbmDpD/1/AL/1GipZGOxXs
         2ggsTkBt6fs0ppfnBMMm6MlIcs+UGSdlR4YBT7Lk0XB9LOU0sDhQgL+Qe+K16okZGIz5
         OUQ1BGO+9PY1acLhbH9IoSilyKjSzqBjrQBzn+Fp6erT/gZuz6PmJ00h87f3EORYTvcR
         8z9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:arc-authentication-results;
        bh=DXkmoOBvb/FEiXkbLpN8XjJhGoKAY2aMloznyjPgQI0=;
        b=pe41fz7CtNknqY7J9Oi7iI7IdQ7dzeU8oSbMHhHOWdxwacfSDggYDByZRjPQ2Fv/wg
         MvAynP9iBlwDx8zOjmWAEJWiu7Zvc+Ebdw+4I8qNtV+clGz77iGQxyAkGGyS/KcvBq1Y
         0M4cbWsSmS9RBt0AT/BdPUh2sUnZHNrrrxryMDwanaAlkzCLWzxuI0oO2FV6rx6DnDjB
         nEcMaE+gQwCm8hpduFkc8Yvw+DXryKUTodCXuFb0LCQQEBkosHFD9jO+B8Ijhh5ECSl3
         uxfSP3NlUguEfWCcuc9sFbQZzoEBRhoh/Z7INuG3m9ZoQDPhfFegb8mELmoXzoIPgqcC
         g0EQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of leo.wen@rock-chips.com designates 211.150.99.136 as permitted sender) smtp.mailfrom=leo.wen@rock-chips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of leo.wen@rock-chips.com designates 211.150.99.136 as permitted sender) smtp.mailfrom=leo.wen@rock-chips.com
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: leo.wen@rock-chips.com
X-FST-TO: eddie.cai@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: leo.wen@rock-chips.com
X-UNIQUE-TAG: <c7a3cc8e8a9a56f2acf1b7da3fa4f109>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH V3 1/2] [media] Add Rockchip RK1608 driver
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Greg KH
 <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 jacob2.chen@rock-chips.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-media@vger.kernel.org, Eddie Cai <eddie.cai@rock-chips.com>
References: <1520301560-114573-1-git-send-email-leo.wen@rock-chips.com>
 <1520301560-114573-2-git-send-email-leo.wen@rock-chips.com>
 <CACRpkdYKNiaEqCNyWq=xjOs3Xz0_YRkhkWkxuS4okD-XRVRj9w@mail.gmail.com>
From: leo <leo.wen@rock-chips.com>
Message-ID: <ea9ffd16-4c8e-f474-1886-05134024e519@rock-chips.com>
Date: Wed, 7 Mar 2018 20:02:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdYKNiaEqCNyWq=xjOs3Xz0_YRkhkWkxuS4okD-XRVRj9w@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------CBBC658675A5105D5E037BE3"
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594151753514968819?=
X-GMAIL-MSGID: =?utf-8?q?1594280280194872155?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is a multi-part message in MIME format.
--------------CBBC658675A5105D5E037BE3
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Linus,

Thanks for your advice and guidance, I learned a lot from them.
you are right, i just request it with the flag GPIOD_IN or  GPIOD_OUT...
so I will delete these redundant functions (gpiod_direction_input..etc.).
> On Tue, Mar 6, 2018 at 2:59 AM, Wen Nuan <leo.wen@rock-chips.com> wrote:
>
> Thank you for the patch! Nice improvements over all!
>
>> From: Leo Wen <leo.wen@rock-chips.com>
>>
>> Rk1608 is used as a PreISP to link on Soc, which mainly has two functions.
>> One is to download the firmware of RK1608, and the other is to match the
>> extra sensor such as camera and enable sensor by calling sensor's s_power.
>>
>> use below v4l2-ctl command to capture frames.
>>
>>      v4l2-ctl --verbose -d /dev/video1 --stream-mmap=2
>>      --stream-to=/tmp/stream.out --stream-count=60 --stream-poll
>>
>> use below command to playback the video on your PC.
>>
>>      mplayer ./stream.out -loop 0 -demuxer rawvideo -rawvideo
>>      w=640:h=480:size=$((640*480*3/2)):format=NV12
>>
>> Changes V3:
>> - Instead use the new GPIO API.
> This is looking really nice from a GPIO point of view!
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> The comments below are just nitpicky good-to-have.
>
>> +       pdata->gpios.reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
>> +       if (IS_ERR(pdata->gpios.reset)) {
>> +               dev_err(dev, "could not get reset gpio\n");
>> +               return PTR_ERR(pdata->gpios.reset);
>> +       }
>> +       ret = gpiod_direction_output(pdata->gpios.reset, 0);
>> +       if (ret) {
>> +               dev_err(dev, "reset gpio set output error %d\n", ret);
>> +               return ret;
>> +       }
> So what you do here is first assert reset and then de-assert it,
> triggering a reset? Maybe you should add a comment
> about that so people get it.
>
>> +       pdata->gpios.irq = devm_gpiod_get(dev, "irq", GPIOD_OUT_LOW);
>> +       if (IS_ERR(pdata->gpios.irq)) {
>> +               dev_err(dev, "could not get irq gpio\n");
>> +               return PTR_ERR(pdata->gpios.irq);
>> +       }
>> +       ret = gpiod_direction_input(pdata->gpios.irq);
>> +       if (ret) {
>> +               dev_err(dev, "GPIO irq set output error %d\n", ret);
>> +               return ret;
>> +       }
> Why is it necessary to request the GPIO as output
> and drive it low and then immediately turn it into an input?
> Why not just request it with the flag GPIOD_IN and
> skip the second statement?
>
>> +       pdata->gpios.pdown = devm_gpiod_get(dev, "powerdown", GPIOD_OUT_HIGH);
>> +       if (IS_ERR(pdata->gpios.pdown)) {
>> +               dev_err(dev, "could not get powerdown gpio\n");
>> +               return PTR_ERR(pdata->gpios.pdown);
>> +       }
>> +       ret = gpiod_direction_output(pdata->gpios.pdown, 0);
>> +       if (ret) {
>> +               dev_err(dev, "GPIO powerdown set output error %d\n", ret);
>> +               return ret;
>> +       }
> This looks dangerous. Like you assert powerdown and then de-assert
> it (similar to reset above). Why not just request it as
> GPIOD_OUT_LOW?
>
>> +       pdata->gpios.sleepst = devm_gpiod_get(dev, "sleepst", GPIOD_OUT_HIGH);
>> +       if (IS_ERR(pdata->gpios.sleepst)) {
>> +               dev_err(dev, "Could not get powerdown gpio\n");
>> +               return PTR_ERR(pdata->gpios.sleepst);
>> +       }
>> +       ret = gpiod_direction_input(pdata->gpios.sleepst);
>> +       if (ret) {
>> +               dev_err(dev, "GPIO sleepst set input error %d\n", ret);
>> +               return ret;
>> +       }
> Just request as GPIOD_IN and skip the second statement?
>
>> +       pdata->gpios.wakeup = devm_gpiod_get(dev, "wakeup", GPIOD_OUT_HIGH);
>> +       if (IS_ERR(pdata->gpios.wakeup)) {
>> +               dev_err(dev, "Could not get wakeup gpio\n");
>> +               return PTR_ERR(pdata->gpios.wakeup);
>> +       }
>> +       ret = gpiod_direction_output(pdata->gpios.wakeup, 0);
>> +       if (ret) {
>> +               dev_err(dev, "GPIO wakeup set output error %d\n", ret);
>> +               return ret;
>> +       }
> Just request as GPIOD_OUT_LOW?
>
>> +struct rk1608_gpios {
>> +       struct gpio_desc        *reset;
>> +       struct gpio_desc        *irq;
>> +       struct gpio_desc        *sleepst;
>> +       struct gpio_desc        *wakeup;
>> +       struct gpio_desc        *pdown;
>> +};
> Very nice :)
>
> Yours,
> Linus Walleij
>
>
>


--------------CBBC658675A5105D5E037BE3
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    Hi Linus,<br>
    <br>
    Thanks for your advice and guidance, <span id="w_100" class="">I </span><span
      id="w_101" class="">learned </span><span id="w_102">a </span><span
      id="w_103" class="">lot </span><span id="w_104" class="">from </span><span
      id="w_105">them.<br>
      you are right, </span>i just request it with the flag GPIOD_IN
    or  GPIOD_OUT...<br>
    so I will delete these redundant functions
    (gpiod_direction_input..etc.).<br>
    <span id="w_105"></span>
    <blockquote type="cite"
cite="mid:CACRpkdYKNiaEqCNyWq=xjOs3Xz0_YRkhkWkxuS4okD-XRVRj9w@mail.gmail.com">
      <pre wrap="">On Tue, Mar 6, 2018 at 2:59 AM, Wen Nuan <a class="moz-txt-link-rfc2396E" href="mailto:leo.wen@rock-chips.com">&lt;leo.wen@rock-chips.com&gt;</a> wrote:

Thank you for the patch! Nice improvements over all!

</pre>
      <blockquote type="cite">
        <pre wrap="">From: Leo Wen <a class="moz-txt-link-rfc2396E" href="mailto:leo.wen@rock-chips.com">&lt;leo.wen@rock-chips.com&gt;</a>

Rk1608 is used as a PreISP to link on Soc, which mainly has two functions.
One is to download the firmware of RK1608, and the other is to match the
extra sensor such as camera and enable sensor by calling sensor's s_power.

use below v4l2-ctl command to capture frames.

    v4l2-ctl --verbose -d /dev/video1 --stream-mmap=2
    --stream-to=/tmp/stream.out --stream-count=60 --stream-poll

use below command to playback the video on your PC.

    mplayer ./stream.out -loop 0 -demuxer rawvideo -rawvideo
    w=640:h=480:size=$((640*480*3/2)):format=NV12

Changes V3:
- Instead use the new GPIO API.
</pre>
      </blockquote>
      <pre wrap="">
This is looking really nice from a GPIO point of view!
Reviewed-by: Linus Walleij <a class="moz-txt-link-rfc2396E" href="mailto:linus.walleij@linaro.org">&lt;linus.walleij@linaro.org&gt;</a>

The comments below are just nitpicky good-to-have.

</pre>
      <blockquote type="cite">
        <pre wrap="">+       pdata-&gt;gpios.reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+       if (IS_ERR(pdata-&gt;gpios.reset)) {
+               dev_err(dev, "could not get reset gpio\n");
+               return PTR_ERR(pdata-&gt;gpios.reset);
+       }
+       ret = gpiod_direction_output(pdata-&gt;gpios.reset, 0);
+       if (ret) {
+               dev_err(dev, "reset gpio set output error %d\n", ret);
+               return ret;
+       }
</pre>
      </blockquote>
      <pre wrap="">
So what you do here is first assert reset and then de-assert it,
triggering a reset? Maybe you should add a comment
about that so people get it.

</pre>
      <blockquote type="cite">
        <pre wrap="">+       pdata-&gt;gpios.irq = devm_gpiod_get(dev, "irq", GPIOD_OUT_LOW);
+       if (IS_ERR(pdata-&gt;gpios.irq)) {
+               dev_err(dev, "could not get irq gpio\n");
+               return PTR_ERR(pdata-&gt;gpios.irq);
+       }
+       ret = gpiod_direction_input(pdata-&gt;gpios.irq);
+       if (ret) {
+               dev_err(dev, "GPIO irq set output error %d\n", ret);
+               return ret;
+       }
</pre>
      </blockquote>
      <pre wrap="">
Why is it necessary to request the GPIO as output
and drive it low and then immediately turn it into an input?
Why not just request it with the flag GPIOD_IN and
skip the second statement?

</pre>
      <blockquote type="cite">
        <pre wrap="">+       pdata-&gt;gpios.pdown = devm_gpiod_get(dev, "powerdown", GPIOD_OUT_HIGH);
+       if (IS_ERR(pdata-&gt;gpios.pdown)) {
+               dev_err(dev, "could not get powerdown gpio\n");
+               return PTR_ERR(pdata-&gt;gpios.pdown);
+       }
+       ret = gpiod_direction_output(pdata-&gt;gpios.pdown, 0);
+       if (ret) {
+               dev_err(dev, "GPIO powerdown set output error %d\n", ret);
+               return ret;
+       }
</pre>
      </blockquote>
      <pre wrap="">
This looks dangerous. Like you assert powerdown and then de-assert
it (similar to reset above). Why not just request it as
GPIOD_OUT_LOW?

</pre>
      <blockquote type="cite">
        <pre wrap="">+       pdata-&gt;gpios.sleepst = devm_gpiod_get(dev, "sleepst", GPIOD_OUT_HIGH);
+       if (IS_ERR(pdata-&gt;gpios.sleepst)) {
+               dev_err(dev, "Could not get powerdown gpio\n");
+               return PTR_ERR(pdata-&gt;gpios.sleepst);
+       }
+       ret = gpiod_direction_input(pdata-&gt;gpios.sleepst);
+       if (ret) {
+               dev_err(dev, "GPIO sleepst set input error %d\n", ret);
+               return ret;
+       }
</pre>
      </blockquote>
      <pre wrap="">
Just request as GPIOD_IN and skip the second statement?

</pre>
      <blockquote type="cite">
        <pre wrap="">+       pdata-&gt;gpios.wakeup = devm_gpiod_get(dev, "wakeup", GPIOD_OUT_HIGH);
+       if (IS_ERR(pdata-&gt;gpios.wakeup)) {
+               dev_err(dev, "Could not get wakeup gpio\n");
+               return PTR_ERR(pdata-&gt;gpios.wakeup);
+       }
+       ret = gpiod_direction_output(pdata-&gt;gpios.wakeup, 0);
+       if (ret) {
+               dev_err(dev, "GPIO wakeup set output error %d\n", ret);
+               return ret;
+       }
</pre>
      </blockquote>
      <pre wrap="">
Just request as GPIOD_OUT_LOW?

</pre>
      <blockquote type="cite">
        <pre wrap="">+struct rk1608_gpios {
+       struct gpio_desc        *reset;
+       struct gpio_desc        *irq;
+       struct gpio_desc        *sleepst;
+       struct gpio_desc        *wakeup;
+       struct gpio_desc        *pdown;
+};
</pre>
      </blockquote>
      <pre wrap="">
Very nice :)

Yours,
Linus Walleij



</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------CBBC658675A5105D5E037BE3--
