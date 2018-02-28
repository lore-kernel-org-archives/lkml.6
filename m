Return-Path: <rrajk@nvidia.com>
X-Google-Smtp-Source: AG47ELtHZw1uT2L+7uA0uyoZbtgmgnBR1M/JD3UJ7GrV3nQ6t3F1lv4AgIwITaVSA1Bsca406pzh
ARC-Seal: i=1; a=rsa-sha256; t=1519798062; cv=none;
        d=google.com; s=arc-20160816;
        b=YvIpC39Aoth/4rhcU9l4DEGh2VFkQLybvdeichp9hOXTyhj6gI764m2gfqMF83QG46
         p9te9XH/5fJx6SI5zJW9mI75KfDYm7H7URMVfk+LzxLSVlewHU9fPvhlTsx/6EEfpR3B
         4/nchKzEdxvmV35xmxfRvHWDbSLcfPeguqYxmiUBggZndriey2WZI4ZSz2UM2QquOagK
         HiYjX5ghwQVfl1vkodcF9l8jAonHtNwthrICqPec8JP8+O5T8A0o5vuqzH5BEFpiGvG9
         5/PZ2ieD9apubMKqxxAC8OSV/9NF6z+6Dl79oFAVTUsn8dJAoj9O7dN5XsjZ2OOnfhPu
         ULIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:cc
         :references:to:subject:arc-authentication-results;
        bh=3N118RJMI7cO49/TOqYFWSsgsUfQOg9BpasYeiCCSNw=;
        b=uKVyv+aXfOE87q2MtIxVVDwlY5sdhsTWHqiNsnlORoVb19GfEOEABKyWSM8mtZB+OU
         SOfo8OuKJvRCPoZdh2AEGOMuo9PR/D/Obo6Ok4cMbTuk+5fIsdyB4FGlqa8s5nLXFlIV
         6DrxiCcsQupwsgrekcfGlEDRdaHvKdDAdpZZbSQRBfayWfoaa/WhOOGHvJykfvdm16DQ
         spEQnSezTw2U9ahmeogKYQUmLzSDJreaTYuNDDTsuy7DOcBF+kRTUadjvPDbwn0eeMZR
         qMGdYldkzKibXZh1WGH4pl5U7TRMtA91TSZASuh7Qtlrct4qW0aZupLIk0OiY6Z3f825
         Drfw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of rrajk@nvidia.com designates 216.228.121.64 as permitted sender) smtp.mailfrom=rrajk@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of rrajk@nvidia.com designates 216.228.121.64 as permitted sender) smtp.mailfrom=rrajk@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
X-PGP-Universal: processed;
	by hqpgpgate101.nvidia.com on Tue, 27 Feb 2018 22:07:41 -0800
Subject: Re: [PATCH 05/10] hwmon: generic-pwm-tachometer: Add generic PWM
 based tachometer
To: Guenter Roeck <linux@roeck-us.net>, <robh+dt@kernel.org>,
	<mark.rutland@arm.com>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jdelvare@suse.com>, <corbet@lwn.net>, <catalin.marinas@arm.com>,
	<will.deacon@arm.com>, <kstewart@linuxfoundation.org>,
	<gregkh@linuxfoundation.org>, <pombredanne@nexb.com>,
	<mmaddireddy@nvidia.com>, <mperttunen@nvidia.com>, <arnd@arndb.de>,
	<timur@codeaurora.org>, <andy.gross@linaro.org>, <xuwei5@hisilicon.com>,
	<elder@linaro.org>, <heiko@sntech.de>, <krzk@kernel.org>,
	<ard.biesheuvel@linaro.org>
References: <1519196339-9377-1-git-send-email-rrajk@nvidia.com>
 <1519196339-9377-6-git-send-email-rrajk@nvidia.com>
 <5172edff-fe29-7ed1-f0d2-b0359ea2c24d@roeck-us.net>
 <2510b525-ec36-b49d-5a62-81f335c0d10d@nvidia.com>
 <cfe0d0ce-3a89-bad0-85ba-6edf1135d2dc@roeck-us.net>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pwm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-hwmon@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <ldewangan@nvidia.com>
From: Rajkumar Rampelli <rrajk@nvidia.com>
Message-ID: <901cf469-1f7d-23f2-e42f-4ea133ef12fc@nvidia.com>
Date: Wed, 28 Feb 2018 11:37:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <cfe0d0ce-3a89-bad0-85ba-6edf1135d2dc@roeck-us.net>
X-Originating-IP: [10.19.65.123]
X-ClientProxiedBy: BGMAIL101.nvidia.com (10.25.59.10) To bgmail103.nvidia.com
 (10.25.59.12)
Content-Type: multipart/alternative;
	boundary="------------69219CEED6A8032BB783A7C8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592992898629636853?=
X-GMAIL-MSGID: =?utf-8?q?1593623773652916678?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--------------69219CEED6A8032BB783A7C8
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit


On Wednesday 28 February 2018 11:28 AM, Guenter Roeck wrote:
> On 02/27/2018 09:38 PM, Rajkumar Rampelli wrote:
>>
>> On Wednesday 21 February 2018 08:20 PM, Guenter Roeck wrote:
>>> On 02/20/2018 10:58 PM, Rajkumar Rampelli wrote:
>>>> Add generic PWM based tachometer driver via HWMON interface
>>>> to report the RPM of motor. This drivers get the period/duty
>>>> cycle from PWM IP which captures the motor PWM output.
>>>>
>>>> This driver implements a simple interface for monitoring the speed of
>>>> a fan and exposes it in roatations per minute (RPM) to the user space
>>>> by using the hwmon's sysfs interface
>>>>
>>>> Signed-off-by: Rajkumar Rampelli <rrajk@nvidia.com>
>>>> ---
>>>>   Documentation/hwmon/generic-pwm-tachometer |  17 +++++
>>>>   drivers/hwmon/Kconfig                      |  10 +++
>>>>   drivers/hwmon/Makefile                     |   1 +
>>>>   drivers/hwmon/generic-pwm-tachometer.c     | 112 
>>>> +++++++++++++++++++++++++++++
>>>>   4 files changed, 140 insertions(+)
>>>>   create mode 100644 Documentation/hwmon/generic-pwm-tachometer
>>>>   create mode 100644 drivers/hwmon/generic-pwm-tachometer.c
>>>>
>>>> diff --git a/Documentation/hwmon/generic-pwm-tachometer 
>>>> b/Documentation/hwmon/generic-pwm-tachometer
>>>> new file mode 100644
>>>> index 0000000..e0713ee
>>>> --- /dev/null
>>>> +++ b/Documentation/hwmon/generic-pwm-tachometer
>>>> @@ -0,0 +1,17 @@
>>>> +Kernel driver generic-pwm-tachometer
>>>> +====================================
>>>> +
>>>> +This driver enables the use of a PWM module to monitor a fan. It 
>>>> uses the
>>>> +generic PWM interface and can be used on SoCs as along as the SoC 
>>>> supports
>>>> +Tachometer controller that moniors the Fan speed in periods.
>>>> +
>>>> +Author: Rajkumar Rampelli <rrajk@nvidia.com>
>>>> +
>>>> +Description
>>>> +-----------
>>>> +
>>>> +The driver implements a simple interface for monitoring the Fan 
>>>> speed using
>>>> +PWM module and Tachometer controller. It requests period value 
>>>> through PWM
>>>> +capture interface to Tachometer and measures the Rotations per 
>>>> minute using
>>>> +received period value. It exposes the Fan speed in RPM to the user 
>>>> space by
>>>> +using the hwmon's sysfs interface.
>>>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>>>> index ef23553..8912dcb 100644
>>>> --- a/drivers/hwmon/Kconfig
>>>> +++ b/drivers/hwmon/Kconfig
>>>> @@ -1878,6 +1878,16 @@ config SENSORS_XGENE
>>>>         If you say yes here you get support for the temperature
>>>>         and power sensors for APM X-Gene SoC.
>>>>   +config GENERIC_PWM_TACHOMETER
>>>> +    tristate "Generic PWM based tachometer driver"
>>>> +    depends on PWM
>>>> +    help
>>>> +      Enables a driver to use PWM signal from motor to use
>>>> +      for measuring the motor speed. The RPM is captured by
>>>> +      PWM modules which has PWM capture capability and this
>>>> +      drivers reads the captured data from PWM IP to convert
>>>> +      it to speed in RPM.
>>>> +
>>>>   if ACPI
>>>>     comment "ACPI drivers"
>>>> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
>>>> index f814b4a..9dcc374 100644
>>>> --- a/drivers/hwmon/Makefile
>>>> +++ b/drivers/hwmon/Makefile
>>>> @@ -175,6 +175,7 @@ obj-$(CONFIG_SENSORS_WM8350)    += wm8350-hwmon.o
>>>>   obj-$(CONFIG_SENSORS_XGENE)    += xgene-hwmon.o
>>>>     obj-$(CONFIG_PMBUS)        += pmbus/
>>>> +obj-$(CONFIG_GENERIC_PWM_TACHOMETER) += generic-pwm-tachometer.o
>>>>     ccflags-$(CONFIG_HWMON_DEBUG_CHIP) := -DDEBUG
>>>>   diff --git a/drivers/hwmon/generic-pwm-tachometer.c 
>>>> b/drivers/hwmon/generic-pwm-tachometer.c
>>>> new file mode 100644
>>>> index 0000000..9354d43
>>>> --- /dev/null
>>>> +++ b/drivers/hwmon/generic-pwm-tachometer.c
>>>> @@ -0,0 +1,112 @@
>>>> +/*
>>>> + * Copyright (c) 2017-2018, NVIDIA CORPORATION.  All rights reserved.
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or 
>>>> modify it
>>>> + * under the terms and conditions of the GNU General Public License,
>>>> + * version 2, as published by the Free Software Foundation.
>>>> + *
>>>> + * This program is distributed in the hope it will be useful, but 
>>>> WITHOUT
>>>> + * ANY WARRANTY; without even the implied warranty of 
>>>> MERCHANTABILITY or
>>>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public 
>>>> License for
>>>> + * more details.
>>>> + *
>>>> + */
>>>> +
>>>> +#include <linux/module.h>
>>>> +#include <linux/platform_device.h>
>>>> +#include <linux/err.h>
>>>> +#include <linux/pwm.h>
>>>> +#include <linux/hwmon.h>
>>>> +#include <linux/hwmon-sysfs.h>
>>>> +
>>>> +struct pwm_hwmon_tach {
>>>> +    struct device        *dev;
>>>> +    struct pwm_device    *pwm;
>>>> +    struct device        *hwmon;
>>>> +};
>>>> +
>>>> +static ssize_t show_rpm(struct device *dev, struct 
>>>> device_attribute *attr,
>>>> +            char *buf)
>>>> +{
>>>> +    struct pwm_hwmon_tach *ptt = dev_get_drvdata(dev);
>>>> +    struct pwm_device *pwm = ptt->pwm;
>>>> +    struct pwm_capture result;
>>>> +    int err;
>>>> +    unsigned int rpm = 0;
>>>> +
>>>> +    err = pwm_capture(pwm, &result, 0);
>>>> +    if (err < 0) {
>>>> +        dev_err(ptt->dev, "Failed to capture PWM: %d\n", err);
>>>> +        return err;
>>>> +    }
>>>> +
>>>> +    if (result.period)
>>>> +        rpm = DIV_ROUND_CLOSEST_ULL(60ULL * NSEC_PER_SEC,
>>>> +                        result.period);
>>>> +
>>>> +    return sprintf(buf, "%u\n", rpm);
>>>> +}
>>>> +
>>>> +static SENSOR_DEVICE_ATTR(rpm, 0444, show_rpm, NULL, 0);
>>>> +
>>>> +static struct attribute *pwm_tach_attrs[] = {
>>>> +    &sensor_dev_attr_rpm.dev_attr.attr,
>>>> +    NULL,
>>>> +};
>>>
>>> "rpm" is not a standard hwmon sysfs attribute. If you don't provide
>>> a single standard hwmon sysfs attribute, having a hwmon driver is 
>>> pointless.
>> Guenter Roeck,
>> I will define a new hwmon sysfs attribute node called 
>> "hwmon_tachometer_attributes" in hwmon.h like below and update the 
>> same in tachometer hwmon driver. Is it fine ?
>> enum hwmon_tachometer_attributes {
>
> Are you kidding me ?
>
> Guenter
Sorry, I just wanted to confirm that whether my understanding is correct 
or not before implementing it actually.
Or shall I add this attribute as a part of fan attributes with 
"hwmon_fan_rpm"? or anyother way to do it ? I need your inputs in fixing it.

--------------69219CEED6A8032BB783A7C8
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <br>
    <div class="moz-cite-prefix">On Wednesday 28 February 2018 11:28 AM,
      Guenter Roeck wrote:<br>
    </div>
    <blockquote
      cite="mid:cfe0d0ce-3a89-bad0-85ba-6edf1135d2dc@roeck-us.net"
      type="cite">On 02/27/2018 09:38 PM, Rajkumar Rampelli wrote:
      <br>
      <blockquote type="cite">
        <br>
        On Wednesday 21 February 2018 08:20 PM, Guenter Roeck wrote:
        <br>
        <blockquote type="cite">On 02/20/2018 10:58 PM, Rajkumar
          Rampelli wrote:
          <br>
          <blockquote type="cite">Add generic PWM based tachometer
            driver via HWMON interface
            <br>
            to report the RPM of motor. This drivers get the period/duty
            <br>
            cycle from PWM IP which captures the motor PWM output.
            <br>
            <br>
            This driver implements a simple interface for monitoring the
            speed of
            <br>
            a fan and exposes it in roatations per minute (RPM) to the
            user space
            <br>
            by using the hwmon's sysfs interface
            <br>
            <br>
            Signed-off-by: Rajkumar Rampelli <a class="moz-txt-link-rfc2396E" href="mailto:rrajk@nvidia.com">&lt;rrajk@nvidia.com&gt;</a>
            <br>
            ---
            <br>
              Documentation/hwmon/generic-pwm-tachometer |  17 +++++
            <br>
              drivers/hwmon/Kconfig                      |  10 +++
            <br>
              drivers/hwmon/Makefile                     |   1 +
            <br>
              drivers/hwmon/generic-pwm-tachometer.c     | 112
            +++++++++++++++++++++++++++++
            <br>
              4 files changed, 140 insertions(+)
            <br>
              create mode 100644
            Documentation/hwmon/generic-pwm-tachometer
            <br>
              create mode 100644 drivers/hwmon/generic-pwm-tachometer.c
            <br>
            <br>
            diff --git a/Documentation/hwmon/generic-pwm-tachometer
            b/Documentation/hwmon/generic-pwm-tachometer
            <br>
            new file mode 100644
            <br>
            index 0000000..e0713ee
            <br>
            --- /dev/null
            <br>
            +++ b/Documentation/hwmon/generic-pwm-tachometer
            <br>
            @@ -0,0 +1,17 @@
            <br>
            +Kernel driver generic-pwm-tachometer
            <br>
            +====================================
            <br>
            +
            <br>
            +This driver enables the use of a PWM module to monitor a
            fan. It uses the
            <br>
            +generic PWM interface and can be used on SoCs as along as
            the SoC supports
            <br>
            +Tachometer controller that moniors the Fan speed in
            periods.
            <br>
            +
            <br>
            +Author: Rajkumar Rampelli <a class="moz-txt-link-rfc2396E" href="mailto:rrajk@nvidia.com">&lt;rrajk@nvidia.com&gt;</a>
            <br>
            +
            <br>
            +Description
            <br>
            +-----------
            <br>
            +
            <br>
            +The driver implements a simple interface for monitoring the
            Fan speed using
            <br>
            +PWM module and Tachometer controller. It requests period
            value through PWM
            <br>
            +capture interface to Tachometer and measures the Rotations
            per minute using
            <br>
            +received period value. It exposes the Fan speed in RPM to
            the user space by
            <br>
            +using the hwmon's sysfs interface.
            <br>
            diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
            <br>
            index ef23553..8912dcb 100644
            <br>
            --- a/drivers/hwmon/Kconfig
            <br>
            +++ b/drivers/hwmon/Kconfig
            <br>
            @@ -1878,6 +1878,16 @@ config SENSORS_XGENE
            <br>
                    If you say yes here you get support for the
            temperature
            <br>
                    and power sensors for APM X-Gene SoC.
            <br>
              +config GENERIC_PWM_TACHOMETER
            <br>
            +    tristate "Generic PWM based tachometer driver"
            <br>
            +    depends on PWM
            <br>
            +    help
            <br>
            +      Enables a driver to use PWM signal from motor to use
            <br>
            +      for measuring the motor speed. The RPM is captured by
            <br>
            +      PWM modules which has PWM capture capability and this
            <br>
            +      drivers reads the captured data from PWM IP to
            convert
            <br>
            +      it to speed in RPM.
            <br>
            +
            <br>
              if ACPI
            <br>
                comment "ACPI drivers"
            <br>
            diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
            <br>
            index f814b4a..9dcc374 100644
            <br>
            --- a/drivers/hwmon/Makefile
            <br>
            +++ b/drivers/hwmon/Makefile
            <br>
            @@ -175,6 +175,7 @@ obj-$(CONFIG_SENSORS_WM8350)    +=
            wm8350-hwmon.o
            <br>
              obj-$(CONFIG_SENSORS_XGENE)    += xgene-hwmon.o
            <br>
                obj-$(CONFIG_PMBUS)        += pmbus/
            <br>
            +obj-$(CONFIG_GENERIC_PWM_TACHOMETER) +=
            generic-pwm-tachometer.o
            <br>
                ccflags-$(CONFIG_HWMON_DEBUG_CHIP) := -DDEBUG
            <br>
              diff --git a/drivers/hwmon/generic-pwm-tachometer.c
            b/drivers/hwmon/generic-pwm-tachometer.c
            <br>
            new file mode 100644
            <br>
            index 0000000..9354d43
            <br>
            --- /dev/null
            <br>
            +++ b/drivers/hwmon/generic-pwm-tachometer.c
            <br>
            @@ -0,0 +1,112 @@
            <br>
            +/*
            <br>
            + * Copyright (c) 2017-2018, NVIDIA CORPORATION.  All rights
            reserved.
            <br>
            + *
            <br>
            + * This program is free software; you can redistribute it
            and/or modify it
            <br>
            + * under the terms and conditions of the GNU General Public
            License,
            <br>
            + * version 2, as published by the Free Software Foundation.
            <br>
            + *
            <br>
            + * This program is distributed in the hope it will be
            useful, but WITHOUT
            <br>
            + * ANY WARRANTY; without even the implied warranty of
            MERCHANTABILITY or
            <br>
            + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General
            Public License for
            <br>
            + * more details.
            <br>
            + *
            <br>
            + */
            <br>
            +
            <br>
            +#include &lt;linux/module.h&gt;
            <br>
            +#include &lt;linux/platform_device.h&gt;
            <br>
            +#include &lt;linux/err.h&gt;
            <br>
            +#include &lt;linux/pwm.h&gt;
            <br>
            +#include &lt;linux/hwmon.h&gt;
            <br>
            +#include &lt;linux/hwmon-sysfs.h&gt;
            <br>
            +
            <br>
            +struct pwm_hwmon_tach {
            <br>
            +    struct device        *dev;
            <br>
            +    struct pwm_device    *pwm;
            <br>
            +    struct device        *hwmon;
            <br>
            +};
            <br>
            +
            <br>
            +static ssize_t show_rpm(struct device *dev, struct
            device_attribute *attr,
            <br>
            +            char *buf)
            <br>
            +{
            <br>
            +    struct pwm_hwmon_tach *ptt = dev_get_drvdata(dev);
            <br>
            +    struct pwm_device *pwm = ptt-&gt;pwm;
            <br>
            +    struct pwm_capture result;
            <br>
            +    int err;
            <br>
            +    unsigned int rpm = 0;
            <br>
            +
            <br>
            +    err = pwm_capture(pwm, &amp;result, 0);
            <br>
            +    if (err &lt; 0) {
            <br>
            +        dev_err(ptt-&gt;dev, "Failed to capture PWM: %d\n",
            err);
            <br>
            +        return err;
            <br>
            +    }
            <br>
            +
            <br>
            +    if (result.period)
            <br>
            +        rpm = DIV_ROUND_CLOSEST_ULL(60ULL * NSEC_PER_SEC,
            <br>
            +                        result.period);
            <br>
            +
            <br>
            +    return sprintf(buf, "%u\n", rpm);
            <br>
            +}
            <br>
            +
            <br>
            +static SENSOR_DEVICE_ATTR(rpm, 0444, show_rpm, NULL, 0);
            <br>
            +
            <br>
            +static struct attribute *pwm_tach_attrs[] = {
            <br>
            +    &amp;sensor_dev_attr_rpm.dev_attr.attr,
            <br>
            +    NULL,
            <br>
            +};
            <br>
          </blockquote>
          <br>
          "rpm" is not a standard hwmon sysfs attribute. If you don't
          provide
          <br>
          a single standard hwmon sysfs attribute, having a hwmon driver
          is pointless.
          <br>
        </blockquote>
        Guenter Roeck,
        <br>
        I will define a new hwmon sysfs attribute node called
        "hwmon_tachometer_attributes" in hwmon.h like below and update
        the same in tachometer hwmon driver. Is it fine ?
        <br>
        enum hwmon_tachometer_attributes {
        <br>
      </blockquote>
      <br>
      Are you kidding me ?
      <br>
      <br>
      Guenter
      <br>
    </blockquote>
    Sorry, I just wanted to confirm that whether my understanding is
    correct or not before implementing it actually.<o:p> <br>
    </o:p>Or shall I add this attribute as a part of fan attributes with
    "hwmon_fan_rpm"? or anyother way to do it ? I need your inputs in
    fixing it.<br>
  </body>
</html>

--------------69219CEED6A8032BB783A7C8--
