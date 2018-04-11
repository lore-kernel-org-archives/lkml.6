Return-Path: <jae.hyun.yoo@linux.intel.com>
X-Google-Smtp-Source: AIpwx4+HBcRPS7LOTBa0ET6zwlV+cDhetdlQo5bfEI/XuXLiSya5fJEU7mMU7NUCGD2/Lcu7mFyr
ARC-Seal: i=1; a=rsa-sha256; t=1523484000; cv=none;
        d=google.com; s=arc-20160816;
        b=L5gA89dBYX3KLW9+WySHUHBig22ZTMaMN7ZIhIcJWQYwcud1HtzaVLMqEo8il/3TP5
         kHni3yygty5R8On3iFkeiXaV6C8tqzSKIEK+SvYBH+0njHiASU4mq+cNPYoENzkB3Ao0
         UYN9aBLeYThAOxcnCiPx6jL37zzG3b4xOm6IRlF4pMj/tZ+7iqCKg7VTYU13s/Lv/+Cl
         faN+hDVQ0wUtJkyg8ydwnCcn1jfTSJKrQ0za60EdVKsEW+F+VaqsPDyVf3CSwKHuhuYS
         vHSdK+RbI4F0ygsZVuHC1PkX49zHGPBrJxvVN9iQsEDvqk0OXi8Lrmpx4CU/9XLZK60D
         e06w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=Y+chJpAWyMK7OkSpWfRC3XSLTDIb6ydnirc3jkWrtOs=;
        b=GdPdvvu1Eatphb0v0L3gQ8X4kHn4WzheH/YjAPp/g264sU5JFisPHddSjSQLJxNdmI
         HVpIEiH1/tgiG61RD8N7zt/pH3UgpOevfJVvV4rk5Cn+kmb+HP37HjqSY0XJXVX9KcBY
         u9V/lEFGcPPenKCPAjVlRyjcWI5+nzu7wasTFzVysI/sxS5ZeNXwau3WHp1Sl6IGvSDG
         86sgwkMgOjlXJj4JO8+6kkA91BT4DodBvP3YA0oWYqhZ1bw1WhFuXBirw907dOUxgAVp
         VSi1pGbDzYBHgmJcHvpNZaNhAT2Wb4KwyFgploCL5yTl4UOZSAwenhKTJ8sFJh4/Z0qW
         YZLQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,438,1517904000";
   d="scan'208";a="42625124"
Subject: Re: [PATCH v3 09/10] drivers/hwmon: Add PECI hwmon client drivers
To: Guenter Roeck <linux@roeck-us.net>
Cc: Alan Cox <alan@linux.intel.com>, Andrew Jeffery <andrew@aj.id.au>,
 Andrew Lunn <andrew@lunn.ch>, Andy Shevchenko <andriy.shevchenko@intel.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Fengguang Wu <fengguang.wu@intel.com>, Greg KH <gregkh@linuxfoundation.org>,
 Haiyue Wang <haiyue.wang@linux.intel.com>,
 James Feist <james.feist@linux.intel.com>,
 Jason M Biils <jason.m.bills@linux.intel.com>,
 Jean Delvare <jdelvare@suse.com>, Joel Stanley <joel@jms.id.au>,
 Julia Cartwright <juliac@eso.teric.us>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Milton Miller II <miltonm@us.ibm.com>, Pavel Machek <pavel@ucw.cz>,
 Randy Dunlap <rdunlap@infradead.org>,
 Stef van Os <stef.van.os@prodrive-technologies.com>,
 Sumeet R Pawnikar <sumeet.r.pawnikar@intel.com>,
 Vernon Mauery <vernon.mauery@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 openbmc@lists.ozlabs.org
References: <20180410183212.16787-1-jae.hyun.yoo@linux.intel.com>
 <20180410183212.16787-10-jae.hyun.yoo@linux.intel.com>
 <20180410222800.GA8484@roeck-us.net>
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <637d7812-e567-0bc2-4f08-fbdca0ee85d8@linux.intel.com>
Date: Wed, 11 Apr 2018 14:59:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180410222800.GA8484@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597385144123845129?=
X-GMAIL-MSGID: =?utf-8?q?1597488759391945456?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Guenter,

Thanks a lot for sharing your time. Please see my inline answers.

On 4/10/2018 3:28 PM, Guenter Roeck wrote:
> On Tue, Apr 10, 2018 at 11:32:11AM -0700, Jae Hyun Yoo wrote:
>> This commit adds PECI cputemp and dimmtemp hwmon drivers.
>>
>> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>> Reviewed-by: Haiyue Wang <haiyue.wang@linux.intel.com>
>> Reviewed-by: James Feist <james.feist@linux.intel.com>
>> Reviewed-by: Vernon Mauery <vernon.mauery@linux.intel.com>
>> Cc: Alan Cox <alan@linux.intel.com>
>> Cc: Andrew Jeffery <andrew@aj.id.au>
>> Cc: Andrew Lunn <andrew@lunn.ch>
>> Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Fengguang Wu <fengguang.wu@intel.com>
>> Cc: Greg KH <gregkh@linuxfoundation.org>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> Cc: Jason M Biils <jason.m.bills@linux.intel.com>
>> Cc: Jean Delvare <jdelvare@suse.com>
>> Cc: Joel Stanley <joel@jms.id.au>
>> Cc: Julia Cartwright <juliac@eso.teric.us>
>> Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
>> Cc: Milton Miller II <miltonm@us.ibm.com>
>> Cc: Pavel Machek <pavel@ucw.cz>
>> Cc: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Stef van Os <stef.van.os@prodrive-technologies.com>
>> Cc: Sumeet R Pawnikar <sumeet.r.pawnikar@intel.com>
>> ---
>>   drivers/hwmon/Kconfig         |  28 ++
>>   drivers/hwmon/Makefile        |   2 +
>>   drivers/hwmon/peci-cputemp.c  | 783 ++++++++++++++++++++++++++++++++++++++++++
>>   drivers/hwmon/peci-dimmtemp.c | 432 +++++++++++++++++++++++
>>   4 files changed, 1245 insertions(+)
>>   create mode 100644 drivers/hwmon/peci-cputemp.c
>>   create mode 100644 drivers/hwmon/peci-dimmtemp.c
>>
>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>> index f249a4428458..c52f610f81d0 100644
>> --- a/drivers/hwmon/Kconfig
>> +++ b/drivers/hwmon/Kconfig
>> @@ -1259,6 +1259,34 @@ config SENSORS_NCT7904
>>   	  This driver can also be built as a module.  If so, the module
>>   	  will be called nct7904.
>>   
>> +config SENSORS_PECI_CPUTEMP
>> +	tristate "PECI CPU temperature monitoring support"
>> +	depends on OF
>> +	depends on PECI
>> +	help
>> +	  If you say yes here you get support for the generic Intel PECI
>> +	  cputemp driver which provides Digital Thermal Sensor (DTS) thermal
>> +	  readings of the CPU package and CPU cores that are accessible using
>> +	  the PECI Client Command Suite via the processor PECI client.
>> +	  Check Documentation/hwmon/peci-cputemp for details.
>> +
>> +	  This driver can also be built as a module.  If so, the module
>> +	  will be called peci-cputemp.
>> +
>> +config SENSORS_PECI_DIMMTEMP
>> +	tristate "PECI DIMM temperature monitoring support"
>> +	depends on OF
>> +	depends on PECI
>> +	help
>> +	  If you say yes here you get support for the generic Intel PECI hwmon
>> +	  driver which provides Digital Thermal Sensor (DTS) thermal readings of
>> +	  DIMM components that are accessible using the PECI Client Command
>> +	  Suite via the processor PECI client.
>> +	  Check Documentation/hwmon/peci-dimmtemp for details.
>> +
>> +	  This driver can also be built as a module.  If so, the module
>> +	  will be called peci-dimmtemp.
>> +
>>   config SENSORS_NSA320
>>   	tristate "ZyXEL NSA320 and compatible fan speed and temperature sensors"
>>   	depends on GPIOLIB && OF
>> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
>> index e7d52a36e6c4..48d9598fcd3a 100644
>> --- a/drivers/hwmon/Makefile
>> +++ b/drivers/hwmon/Makefile
>> @@ -136,6 +136,8 @@ obj-$(CONFIG_SENSORS_NCT7802)	+= nct7802.o
>>   obj-$(CONFIG_SENSORS_NCT7904)	+= nct7904.o
>>   obj-$(CONFIG_SENSORS_NSA320)	+= nsa320-hwmon.o
>>   obj-$(CONFIG_SENSORS_NTC_THERMISTOR)	+= ntc_thermistor.o
>> +obj-$(CONFIG_SENSORS_PECI_CPUTEMP)	+= peci-cputemp.o
>> +obj-$(CONFIG_SENSORS_PECI_DIMMTEMP)	+= peci-dimmtemp.o
>>   obj-$(CONFIG_SENSORS_PC87360)	+= pc87360.o
>>   obj-$(CONFIG_SENSORS_PC87427)	+= pc87427.o
>>   obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
>> diff --git a/drivers/hwmon/peci-cputemp.c b/drivers/hwmon/peci-cputemp.c
>> new file mode 100644
>> index 000000000000..f0bc92687512
>> --- /dev/null
>> +++ b/drivers/hwmon/peci-cputemp.c
>> @@ -0,0 +1,783 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (c) 2018 Intel Corporation
>> +
>> +#include <linux/delay.h>
>> +#include <linux/hwmon.h>
>> +#include <linux/hwmon-sysfs.h>
> 
> Is this include needed ?
> 

No it isn't. Will drop the line.

>> +#include <linux/jiffies.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <linux/peci.h>
>> +
>> +#define TEMP_TYPE_PECI        6  /* Sensor type 6: Intel PECI */
>> +
>> +#define CORE_MAX_ON_HSX       18 /* Max number of cores on Haswell */
>> +#define CORE_MAX_ON_BDX       24 /* Max number of cores on Broadwell */
>> +#define CORE_MAX_ON_SKX       28 /* Max number of cores on Skylake */
>> +
>> +#define DEFAULT_CHANNEL_NUMS  5
>> +#define CORETEMP_CHANNEL_NUMS CORE_MAX_ON_SKX
>> +#define CPUTEMP_CHANNEL_NUMS  (DEFAULT_CHANNEL_NUMS + CORETEMP_CHANNEL_NUMS)
>> +
>> +#define CLIENT_CPU_ID_MASK    0xf0ff0  /* Mask for Family / Model info */
>> +
>> +#define UPDATE_INTERVAL_MIN   HZ
>> +
>> +enum cpu_gens {
>> +	CPU_GEN_HSX, /* Haswell Xeon */
>> +	CPU_GEN_BRX, /* Broadwell Xeon */
>> +	CPU_GEN_SKX, /* Skylake Xeon */
>> +	CPU_GEN_MAX
>> +};
>> +
>> +struct cpu_gen_info {
>> +	u32 type;
>> +	u32 cpu_id;
>> +	u32 core_max;
>> +};
>> +
>> +struct temp_data {
>> +	bool valid;
>> +	s32  value;
>> +	unsigned long last_updated;
>> +};
>> +
>> +struct temp_group {
>> +	struct temp_data die;
>> +	struct temp_data dts_margin;
>> +	struct temp_data tcontrol;
>> +	struct temp_data tthrottle;
>> +	struct temp_data tjmax;
>> +	struct temp_data core[CORETEMP_CHANNEL_NUMS];
>> +};
>> +
>> +struct peci_cputemp {
>> +	struct peci_client *client;
>> +	struct device *dev;
>> +	char name[PECI_NAME_SIZE];
>> +	struct temp_group temp;
>> +	u8 addr;
>> +	uint cpu_no;
>> +	const struct cpu_gen_info *gen_info;
>> +	u32 core_mask;
>> +	u32 temp_config[CPUTEMP_CHANNEL_NUMS + 1];
>> +	uint config_idx;
>> +	struct hwmon_channel_info temp_info;
>> +	const struct hwmon_channel_info *info[2];
>> +	struct hwmon_chip_info chip;
>> +};
>> +
>> +enum cputemp_channels {
>> +	channel_die,
>> +	channel_dts_mrgn,
>> +	channel_tcontrol,
>> +	channel_tthrottle,
>> +	channel_tjmax,
>> +	channel_core,
>> +};
>> +
>> +static const struct cpu_gen_info cpu_gen_info_table[] = {
>> +	{ .type = CPU_GEN_HSX,
>> +	  .cpu_id = 0x306f0, /* Family code: 6, Model number: 63 (0x3f) */
>> +	  .core_max = CORE_MAX_ON_HSX },
>> +	{ .type = CPU_GEN_BRX,
>> +	  .cpu_id = 0x406f0, /* Family code: 6, Model number: 79 (0x4f) */
>> +	  .core_max = CORE_MAX_ON_BDX },
>> +	{ .type = CPU_GEN_SKX,
>> +	  .cpu_id = 0x50650, /* Family code: 6, Model number: 85 (0x55) */
>> +	  .core_max = CORE_MAX_ON_SKX },
>> +};
>> +
>> +static const u32 config_table[DEFAULT_CHANNEL_NUMS + 1] = {
>> +	/* Die temperature */
>> +	HWMON_T_LABEL | HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
>> +	HWMON_T_CRIT_HYST,
>> +
>> +	/* DTS margin temperature */
>> +	HWMON_T_LABEL | HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_LCRIT,
>> +
>> +	/* Tcontrol temperature */
>> +	HWMON_T_LABEL | HWMON_T_INPUT | HWMON_T_CRIT,
>> +
>> +	/* Tthrottle temperature */
>> +	HWMON_T_LABEL | HWMON_T_INPUT,
>> +
>> +	/* Tjmax temperature */
>> +	HWMON_T_LABEL | HWMON_T_INPUT,
>> +
>> +	/* Core temperature - for all core channels */
>> +	HWMON_T_LABEL | HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
>> +	HWMON_T_CRIT_HYST,
>> +};
>> +
>> +static const char *cputemp_label[CPUTEMP_CHANNEL_NUMS] = {
>> +	"Die",
>> +	"DTS margin",
>> +	"Tcontrol",
>> +	"Tthrottle",
>> +	"Tjmax",
>> +	"Core 0", "Core 1", "Core 2", "Core 3",
>> +	"Core 4", "Core 5", "Core 6", "Core 7",
>> +	"Core 8", "Core 9", "Core 10", "Core 11",
>> +	"Core 12", "Core 13", "Core 14", "Core 15",
>> +	"Core 16", "Core 17", "Core 18", "Core 19",
>> +	"Core 20", "Core 21", "Core 22", "Core 23",
>> +};
>> +
>> +static int send_peci_cmd(struct peci_cputemp *priv,
>> +			 enum peci_cmd cmd,
>> +			 void *msg)
>> +{
>> +	return peci_command(priv->client->adapter, cmd, msg);
>> +}
>> +
>> +static int need_update(struct temp_data *temp)
> 
> Please use bool.
> 

Okay. I'll use bool instead of int.

>> +{
>> +	if (temp->valid &&
>> +	    time_before(jiffies, temp->last_updated + UPDATE_INTERVAL_MIN))
>> +		return 0;
>> +
>> +	return 1;
>> +}
>> +
>> +static void mark_updated(struct temp_data *temp)
>> +{
>> +	temp->valid = true;
>> +	temp->last_updated = jiffies;
>> +}
>> +
>> +static s32 ten_dot_six_to_millidegree(s32 val)
>> +{
>> +	return ((val ^ 0x8000) - 0x8000) * 1000 / 64;
>> +}
>> +
>> +static int get_tjmax(struct peci_cputemp *priv)
>> +{
>> +	struct peci_rd_pkg_cfg_msg msg;
>> +	int rc;
>> +
>> +	if (!priv->temp.tjmax.valid) {
>> +		msg.addr = priv->addr;
>> +		msg.index = MBX_INDEX_TEMP_TARGET;
>> +		msg.param = 0;
>> +		msg.rx_len = 4;
>> +
>> +		rc = send_peci_cmd(priv, PECI_CMD_RD_PKG_CFG, &msg);
>> +		if (rc)
>> +			return rc;
>> +
>> +		priv->temp.tjmax.value = (s32)msg.pkg_config[2] * 1000;
>> +		priv->temp.tjmax.valid = true;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int get_tcontrol(struct peci_cputemp *priv)
>> +{
>> +	struct peci_rd_pkg_cfg_msg msg;
>> +	s32 tcontrol_margin;
>> +	s32 tthrottle_offset;
>> +	int rc;
>> +
>> +	if (!need_update(&priv->temp.tcontrol))
>> +		return 0;
>> +
>> +	rc = get_tjmax(priv);
>> +	if (rc)
>> +		return rc;
>> +
>> +	msg.addr = priv->addr;
>> +	msg.index = MBX_INDEX_TEMP_TARGET;
>> +	msg.param = 0;
>> +	msg.rx_len = 4;
>> +
>> +	rc = send_peci_cmd(priv, PECI_CMD_RD_PKG_CFG, &msg);
>> +	if (rc)
>> +		return rc;
>> +
>> +	tcontrol_margin = msg.pkg_config[1];
>> +	tcontrol_margin = ((tcontrol_margin ^ 0x80) - 0x80) * 1000;
>> +	priv->temp.tcontrol.value = priv->temp.tjmax.value - tcontrol_margin;
>> +
>> +	tthrottle_offset = (msg.pkg_config[3] & 0x2f) * 1000;
>> +	priv->temp.tthrottle.value = priv->temp.tjmax.value - tthrottle_offset;
>> +
>> +	mark_updated(&priv->temp.tcontrol);
>> +	mark_updated(&priv->temp.tthrottle);
>> +
>> +	return 0;
>> +}
>> +
>> +static int get_tthrottle(struct peci_cputemp *priv)
>> +{
>> +	struct peci_rd_pkg_cfg_msg msg;
>> +	s32 tcontrol_margin;
>> +	s32 tthrottle_offset;
>> +	int rc;
>> +
>> +	if (!need_update(&priv->temp.tthrottle))
>> +		return 0;
>> +
>> +	rc = get_tjmax(priv);
>> +	if (rc)
>> +		return rc;
>> +
>> +	msg.addr = priv->addr;
>> +	msg.index = MBX_INDEX_TEMP_TARGET;
>> +	msg.param = 0;
>> +	msg.rx_len = 4;
>> +
>> +	rc = send_peci_cmd(priv, PECI_CMD_RD_PKG_CFG, &msg);
>> +	if (rc)
>> +		return rc;
>> +
>> +	tthrottle_offset = (msg.pkg_config[3] & 0x2f) * 1000;
>> +	priv->temp.tthrottle.value = priv->temp.tjmax.value - tthrottle_offset;
>> +
>> +	tcontrol_margin = msg.pkg_config[1];
>> +	tcontrol_margin = ((tcontrol_margin ^ 0x80) - 0x80) * 1000;
>> +	priv->temp.tcontrol.value = priv->temp.tjmax.value - tcontrol_margin;
>> +
>> +	mark_updated(&priv->temp.tthrottle);
>> +	mark_updated(&priv->temp.tcontrol);
>> +
>> +	return 0;
>> +}
> 
> I am quite completely missing how the two functions above are different.
> 

The two above functions are slightly different but uses the same PECI 
command which provides both Tthrottle and Tcontrol values in pkg_config 
array so it updates the values to reduce duplicate PECI transactions. 
Probably, combining these two functions into get_ttrottle_and_tcontrol() 
would look better. I'll rewrite it.

>> +
>> +static int get_die_temp(struct peci_cputemp *priv)
>> +{
>> +	struct peci_get_temp_msg msg;
>> +	int rc;
>> +
>> +	if (!need_update(&priv->temp.die))
>> +		return 0;
>> +
>> +	rc = get_tjmax(priv);
>> +	if (rc)
>> +		return rc;
>> +
>> +	msg.addr = priv->addr;
>> +
>> +	rc = send_peci_cmd(priv, PECI_CMD_GET_TEMP, &msg);
>> +	if (rc)
>> +		return rc;
>> +
>> +	priv->temp.die.value = priv->temp.tjmax.value +
>> +			       ((s32)msg.temp_raw * 1000 / 64);
>> +
>> +	mark_updated(&priv->temp.die);
>> +
>> +	return 0;
>> +}
>> +
>> +static int get_dts_margin(struct peci_cputemp *priv)
>> +{
>> +	struct peci_rd_pkg_cfg_msg msg;
>> +	s32 dts_margin;
>> +	int rc;
>> +
>> +	if (!need_update(&priv->temp.dts_margin))
>> +		return 0;
>> +
>> +	msg.addr = priv->addr;
>> +	msg.index = MBX_INDEX_DTS_MARGIN;
>> +	msg.param = 0;
>> +	msg.rx_len = 4;
>> +
>> +	rc = send_peci_cmd(priv, PECI_CMD_RD_PKG_CFG, &msg);
>> +	if (rc)
>> +		return rc;
>> +
>> +	dts_margin = (msg.pkg_config[1] << 8) | msg.pkg_config[0];
>> +
>> +	/**
>> +	 * Processors return a value of DTS reading in 10.6 format
>> +	 * (10 bits signed decimal, 6 bits fractional).
>> +	 * Error codes:
>> +	 *   0x8000: General sensor error
>> +	 *   0x8001: Reserved
>> +	 *   0x8002: Underflow on reading value
>> +	 *   0x8003-0x81ff: Reserved
>> +	 */
>> +	if (dts_margin >= 0x8000 && dts_margin <= 0x81ff)
>> +		return -EIO;
>> +
>> +	dts_margin = ten_dot_six_to_millidegree(dts_margin);
>> +
>> +	priv->temp.dts_margin.value = dts_margin;
>> +
>> +	mark_updated(&priv->temp.dts_margin);
>> +
>> +	return 0;
>> +}
>> +
>> +static int get_core_temp(struct peci_cputemp *priv, int core_index)
>> +{
>> +	struct peci_rd_pkg_cfg_msg msg;
>> +	s32 core_dts_margin;
>> +	int rc;
>> +
>> +	if (!need_update(&priv->temp.core[core_index]))
>> +		return 0;
>> +
>> +	rc = get_tjmax(priv);
>> +	if (rc)
>> +		return rc;
>> +
>> +	msg.addr = priv->addr;
>> +	msg.index = MBX_INDEX_PER_CORE_DTS_TEMP;
>> +	msg.param = core_index;
>> +	msg.rx_len = 4;
>> +
>> +	rc = send_peci_cmd(priv, PECI_CMD_RD_PKG_CFG, &msg);
>> +	if (rc)
>> +		return rc;
>> +
>> +	core_dts_margin = (msg.pkg_config[1] << 8) | msg.pkg_config[0];
>> +
>> +	/**
>> +	 * Processors return a value of the core DTS reading in 10.6 format
>> +	 * (10 bits signed decimal, 6 bits fractional).
>> +	 * Error codes:
>> +	 *   0x8000: General sensor error
>> +	 *   0x8001: Reserved
>> +	 *   0x8002: Underflow on reading value
>> +	 *   0x8003-0x81ff: Reserved
>> +	 */
>> +	if (core_dts_margin >= 0x8000 && core_dts_margin <= 0x81ff)
>> +		return -EIO;
>> +
>> +	core_dts_margin = ten_dot_six_to_millidegree(core_dts_margin);
>> +
>> +	priv->temp.core[core_index].value = priv->temp.tjmax.value +
>> +					    core_dts_margin;
>> +
>> +	mark_updated(&priv->temp.core[core_index]);
>> +
>> +	return 0;
>> +}
>> +
> 
> There is a lot of duplication in those functions. Would it be possible
> to find common code and use functions for it instead of duplicating
> everything several times ?
> 

Are you pointing out this code?
/**
  * Processors return a value of the core DTS reading in 10.6 format
  * (10 bits signed decimal, 6 bits fractional).
  * Error codes:
  *   0x8000: General sensor error
  *   0x8001: Reserved
  *   0x8002: Underflow on reading value
  *   0x8003-0x81ff: Reserved
  */
if (core_dts_margin >= 0x8000 && core_dts_margin <= 0x81ff)
	return -EIO;

Then I'll rewrite it as a function. If not, please point out the 
duplication.

>> +static int find_core_index(struct peci_cputemp *priv, int channel)
>> +{
>> +	int core_channel = channel - DEFAULT_CHANNEL_NUMS;
>> +	int idx, found = 0;
>> +
>> +	for (idx = 0; idx < priv->gen_info->core_max; idx++) {
>> +		if (priv->core_mask & BIT(idx)) {
>> +			if (core_channel == found)
>> +				break;
>> +
>> +			found++;
>> +		}
>> +	}
>> +
>> +	return idx;
> 
> What if nothing is found ?
> 

Core temperature group will be registered only when it detects at least 
one core checked by check_resolved_cores(), so find_core_index() can be 
called only when priv->core_mask has a non-zero value. The 'nothing is 
found' case will not happen.

>> +}
>> +
>> +static int cputemp_read_string(struct device *dev,
>> +			       enum hwmon_sensor_types type,
>> +			       u32 attr, int channel, const char **str)
>> +{
>> +	struct peci_cputemp *priv = dev_get_drvdata(dev);
>> +	int core_index;
>> +
>> +	switch (attr) {
>> +	case hwmon_temp_label:
>> +		if (channel < DEFAULT_CHANNEL_NUMS) {
>> +			*str = cputemp_label[channel];
>> +		} else {
>> +			core_index = find_core_index(priv, channel);
> 
> FWIW, it might be better to pass channel - DEFAULT_CHANNEL_NUMS
> as parameter.
> 

cputemp_read_string() is mapped to read_string member of hwmon_ops 
struct, so hwmon susbsystem passes the channel parameter based on the 
registered channel order. Should I modify hwmon subsystem code?

> What if find_core_index() returns priv->gen_info->core_max, ie
> if it didn't find a core ?
> 

As explained above, find_core index() returns a correct index always.

>> +			*str = cputemp_label[DEFAULT_CHANNEL_NUMS + core_index];
>> +		}
>> +		return 0;
>> +	default:
>> +		return -EOPNOTSUPP;
>> +	}
>> +}
>> +
>> +static int cputemp_read_die(struct device *dev,
>> +			    enum hwmon_sensor_types type,
>> +			    u32 attr, int channel, long *val)
>> +{
>> +	struct peci_cputemp *priv = dev_get_drvdata(dev);
>> +	int rc;
>> +
>> +	switch (attr) {
>> +	case hwmon_temp_input:
>> +		rc = get_die_temp(priv);
>> +		if (rc)
>> +			return rc;
>> +
>> +		*val = priv->temp.die.value;
>> +		return 0;
>> +	case hwmon_temp_max:
>> +		rc = get_tcontrol(priv);
>> +		if (rc)
>> +			return rc;
>> +
>> +		*val = priv->temp.tcontrol.value;
>> +		return 0;
>> +	case hwmon_temp_crit:
>> +		rc = get_tjmax(priv);
>> +		if (rc)
>> +			return rc;
>> +
>> +		*val = priv->temp.tjmax.value;
>> +		return 0;
>> +	case hwmon_temp_crit_hyst:
>> +		rc = get_tcontrol(priv);
>> +		if (rc)
>> +			return rc;
>> +
>> +		*val = priv->temp.tjmax.value - priv->temp.tcontrol.value;
>> +		return 0;
>> +	default:
>> +		return -EOPNOTSUPP;
>> +	}
>> +}
>> +
>> +static int cputemp_read_dts_margin(struct device *dev,
>> +				   enum hwmon_sensor_types type,
>> +				   u32 attr, int channel, long *val)
>> +{
>> +	struct peci_cputemp *priv = dev_get_drvdata(dev);
>> +	int rc;
>> +
>> +	switch (attr) {
>> +	case hwmon_temp_input:
>> +		rc = get_dts_margin(priv);
>> +		if (rc)
>> +			return rc;
>> +
>> +		*val = priv->temp.dts_margin.value;
>> +		return 0;
>> +	case hwmon_temp_min:
>> +		*val = 0;
>> +		return 0;
> 
> This attribute should not exist.
> 

This is an attribute of DTS margin temperature which reflects thermal 
margin to Tcontrol of the CPU package. If it shows '0' means it reached 
to Tcontrol, the first level of thermal warning. If the CPU keeps 
getting hot then this DTS margin shows a negative value until it reaches 
to Tjmax. When the temperature reaches to Tjmax at last then it shows 
the lower critcal value which lcrit indicates as the second level of 
thermal warning.

>> +	case hwmon_temp_lcrit:
>> +		rc = get_tcontrol(priv);
>> +		if (rc)
>> +			return rc;
>> +
>> +		*val = priv->temp.tcontrol.value - priv->temp.tjmax.value;
> 
> lcrit is tcontrol - tjmax, and crit_hyst above is
> tjmax - tcontrol ? How does this make sense ?
> 

Both Tjmax and Tcontrol have positive values and Tjmax is greater than 
Tcontrol always. As explained above, lcrit of DTS margin should show a 
negative value means the margin goes down across '0'. On the other hand, 
crit_hyst of Die temperature should show absolute hyterisis value 
between Tcontrol and Tjmax.

>> +		return 0;
>> +	default:
>> +		return -EOPNOTSUPP;
>> +	}
>> +}
>> +
>> +static int cputemp_read_tcontrol(struct device *dev,
>> +				 enum hwmon_sensor_types type,
>> +				 u32 attr, int channel, long *val)
>> +{
>> +	struct peci_cputemp *priv = dev_get_drvdata(dev);
>> +	int rc;
>> +
>> +	switch (attr) {
>> +	case hwmon_temp_input:
>> +		rc = get_tcontrol(priv);
>> +		if (rc)
>> +			return rc;
>> +
>> +		*val = priv->temp.tcontrol.value;
>> +		return 0;
>> +	case hwmon_temp_crit:
>> +		rc = get_tjmax(priv);
>> +		if (rc)
>> +			return rc;
>> +
>> +		*val = priv->temp.tjmax.value;
>> +		return 0;
> 
> Am I missing something, or is the same temperature reported several times ?
> tjmax is also reported as temp_crit cputemp_read_die(), for example.
> 

This driver provides multiple channels and each channel has its own 
supplement attributes. As you mentioned, Die temperature channel and 
Core temperature channel have their individual crit attributes and they 
reflect the same value, Tjmax. It is not reporting several times but 
reporting the same value.

>> +	default:
>> +		return -EOPNOTSUPP;
>> +	}
>> +}
>> +
>> +static int cputemp_read_tthrottle(struct device *dev,
>> +				  enum hwmon_sensor_types type,
>> +				  u32 attr, int channel, long *val)
>> +{
>> +	struct peci_cputemp *priv = dev_get_drvdata(dev);
>> +	int rc;
>> +
>> +	switch (attr) {
>> +	case hwmon_temp_input:
>> +		rc = get_tthrottle(priv);
>> +		if (rc)
>> +			return rc;
>> +
>> +		*val = priv->temp.tthrottle.value;
>> +		return 0;
>> +	default:
>> +		return -EOPNOTSUPP;
>> +	}
>> +}
>> +
>> +static int cputemp_read_tjmax(struct device *dev,
>> +			      enum hwmon_sensor_types type,
>> +			      u32 attr, int channel, long *val)
>> +{
>> +	struct peci_cputemp *priv = dev_get_drvdata(dev);
>> +	int rc;
>> +
>> +	switch (attr) {
>> +	case hwmon_temp_input:
>> +		rc = get_tjmax(priv);
>> +		if (rc)
>> +			return rc;
>> +
>> +		*val = priv->temp.tjmax.value;
>> +		return 0;
>> +	default:
>> +		return -EOPNOTSUPP;
>> +	}
>> +}
>> +
>> +static int cputemp_read_core(struct device *dev,
>> +			     enum hwmon_sensor_types type,
>> +			     u32 attr, int channel, long *val)
>> +{
>> +	struct peci_cputemp *priv = dev_get_drvdata(dev);
>> +	int core_index = find_core_index(priv, channel);
>> +	int rc;
>> +
>> +	switch (attr) {
>> +	case hwmon_temp_input:
>> +		rc = get_core_temp(priv, core_index);
>> +		if (rc)
>> +			return rc;
>> +
>> +		*val = priv->temp.core[core_index].value;
>> +		return 0;
>> +	case hwmon_temp_max:
>> +		rc = get_tcontrol(priv);
>> +		if (rc)
>> +			return rc;
>> +
>> +		*val = priv->temp.tcontrol.value;
>> +		return 0;
>> +	case hwmon_temp_crit:
>> +		rc = get_tjmax(priv);
>> +		if (rc)
>> +			return rc;
>> +
>> +		*val = priv->temp.tjmax.value;
>> +		return 0;
>> +	case hwmon_temp_crit_hyst:
>> +		rc = get_tcontrol(priv);
>> +		if (rc)
>> +			return rc;
>> +
>> +		*val = priv->temp.tjmax.value - priv->temp.tcontrol.value;
>> +		return 0;
>> +	default:
>> +		return -EOPNOTSUPP;
>> +	}
>> +}
> 
> There is again a lot of duplication in those functions.
> 

Each function is called from cputemp_read() which is mapped to read 
function pointer of hwmon_ops struct. Since each channel has different 
set of attributes so the cputemp_read() calls an individual channel 
handler after checking the channel type. Of course, we can handle all 
attributes of all channels in a single function but the way also needs 
channel type checking code on each attribute.

>> +
>> +static int cputemp_read(struct device *dev,
>> +			enum hwmon_sensor_types type,
>> +			u32 attr, int channel, long *val)
>> +{
>> +	switch (channel) {
>> +	case channel_die:
>> +		return cputemp_read_die(dev, type, attr, channel, val);
>> +	case channel_dts_mrgn:
>> +		return cputemp_read_dts_margin(dev, type, attr, channel, val);
>> +	case channel_tcontrol:
>> +		return cputemp_read_tcontrol(dev, type, attr, channel, val);
>> +	case channel_tthrottle:
>> +		return cputemp_read_tthrottle(dev, type, attr, channel, val);
>> +	case channel_tjmax:
>> +		return cputemp_read_tjmax(dev, type, attr, channel, val);
>> +	default:
>> +		if (channel < CPUTEMP_CHANNEL_NUMS)
>> +			return cputemp_read_core(dev, type, attr, channel, val);
>> +
>> +		return -EOPNOTSUPP;
>> +	}
>> +}
>> +
>> +static umode_t cputemp_is_visible(const void *data,
>> +				  enum hwmon_sensor_types type,
>> +				  u32 attr, int channel)
>> +{
>> +	const struct peci_cputemp *priv = data;
>> +
>> +	if (priv->temp_config[channel] & BIT(attr))
>> +		return 0444;
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct hwmon_ops cputemp_ops = {
>> +	.is_visible = cputemp_is_visible,
>> +	.read_string = cputemp_read_string,
>> +	.read = cputemp_read,
>> +};
>> +
>> +static int check_resolved_cores(struct peci_cputemp *priv)
>> +{
>> +	struct peci_rd_pci_cfg_local_msg msg;
>> +	int rc;
>> +
>> +	if (!(priv->client->adapter->cmd_mask & BIT(PECI_CMD_RD_PCI_CFG_LOCAL)))
>> +		return -EINVAL;
>> +
>> +	/* Get the RESOLVED_CORES register value */
>> +	msg.addr = priv->addr;
>> +	msg.bus = 1;
>> +	msg.device = 30;
>> +	msg.function = 3;
>> +	msg.reg = 0xB4;
> 
> Can this be made less magic with some defines ?
> 

Sure, will use defines instead.

>> +	msg.rx_len = 4;
>> +
>> +	rc = send_peci_cmd(priv, PECI_CMD_RD_PCI_CFG_LOCAL, &msg);
>> +	if (rc)
>> +		return rc;
>> +
>> +	priv->core_mask = msg.pci_config[3] << 24 |
>> +			  msg.pci_config[2] << 16 |
>> +			  msg.pci_config[1] << 8 |
>> +			  msg.pci_config[0];
>> +
>> +	if (!priv->core_mask)
>> +		return -EAGAIN;
>> +
>> +	dev_dbg(priv->dev, "Scanned resolved cores: 0x%x\n", priv->core_mask);
>> +	return 0;
>> +}
>> +
>> +static int create_core_temp_info(struct peci_cputemp *priv)
>> +{
>> +	int rc, i;
>> +
>> +	rc = check_resolved_cores(priv);
>> +	if (!rc) {
>> +		for (i = 0; i < priv->gen_info->core_max; i++) {
>> +			if (priv->core_mask & BIT(i)) {
>> +				priv->temp_config[priv->config_idx++] =
>> +						     config_table[channel_core];
>> +			}
>> +		}
>> +	}
>> +
>> +	return rc;
>> +}
>> +
>> +static int check_cpu_id(struct peci_cputemp *priv)
>> +{
>> +	struct peci_rd_pkg_cfg_msg msg;
>> +	u32 cpu_id;
>> +	int i, rc;
>> +
>> +	msg.addr = priv->addr;
>> +	msg.index = MBX_INDEX_CPU_ID;
>> +	msg.param = PKG_ID_CPU_ID;
>> +	msg.rx_len = 4;
>> +
>> +	rc = send_peci_cmd(priv, PECI_CMD_RD_PKG_CFG, &msg);
>> +	if (rc)
>> +		return rc;
>> +
>> +	cpu_id = ((msg.pkg_config[2] << 16) | (msg.pkg_config[1] << 8) |
>> +		  msg.pkg_config[0]) & CLIENT_CPU_ID_MASK;
>> +
>> +	for (i = 0; i < CPU_GEN_MAX; i++) {
>> +		if (cpu_id == cpu_gen_info_table[i].cpu_id) {
>> +			priv->gen_info = &cpu_gen_info_table[i];
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (!priv->gen_info)
>> +		return -ENODEV;
>> +
>> +	dev_dbg(priv->dev, "CPU_ID: 0x%x\n", cpu_id);
>> +	return 0;
>> +}
>> +
>> +static int peci_cputemp_probe(struct peci_client *client)
>> +{
>> +	struct device *dev = &client->dev;
>> +	struct peci_cputemp *priv;
>> +	struct device *hwmon_dev;
>> +	int rc;
>> +
>> +	if ((client->adapter->cmd_mask &
>> +	    (BIT(PECI_CMD_GET_TEMP) | BIT(PECI_CMD_RD_PKG_CFG))) !=
>> +	    (BIT(PECI_CMD_GET_TEMP) | BIT(PECI_CMD_RD_PKG_CFG))) {
>> +		dev_err(dev, "Client doesn't support temperature monitoring\n");
>> +		return -EINVAL;
> 
> Does this mean there will be an error message for each non-supported CPU ?
> Why ?
> 

For proper operation of this driver, PECI_CMD_GET_TEMP and 
PECI_CMD_RD_PKG_CFG have to be supported by a client CPU. 
PECI_CMD_GET_TEMP is provided as a default command but 
PECI_CMD_RD_PKG_CFG depends on PECI minor revision of a CPU package so 
this checking is needed.

>> +	}
>> +
>> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	dev_set_drvdata(dev, priv);
>> +	priv->client = client;
>> +	priv->dev = dev;
>> +	priv->addr = client->addr;
>> +	priv->cpu_no = priv->addr - PECI_BASE_ADDR;
>> +
>> +	snprintf(priv->name, PECI_NAME_SIZE, "peci_cputemp.cpu%d",
>> +		 priv->cpu_no);
>> +
>> +	rc = check_cpu_id(priv);
>> +	if (rc) {
>> +		dev_err(dev, "Client CPU is not supported\n");
> 
> -ENODEV is not an error, and should not result in an error message.
> Besides, the error can also be propagated from peci core code,
> and may well be something else.
> 

Got it. I'll remove the error message and will add a proper handling 
code into PECI core.

>> +		return rc;
>> +	}
>> +
>> +	priv->temp_config[priv->config_idx++] = config_table[channel_die];
>> +	priv->temp_config[priv->config_idx++] = config_table[channel_dts_mrgn];
>> +	priv->temp_config[priv->config_idx++] = config_table[channel_tcontrol];
>> +	priv->temp_config[priv->config_idx++] = config_table[channel_tthrottle];
>> +	priv->temp_config[priv->config_idx++] = config_table[channel_tjmax];
>> +
>> +	rc = create_core_temp_info(priv);
>> +	if (rc)
>> +		dev_dbg(dev, "Failed to create core temp info\n");
> 
> Then what ? Shouldn't this result in probe deferral or something more useful
> instead of just being ignored ?
> 

This driver can't support core temperature monitoring if a CPU doesn't 
support PECI_CMD_RD_PCI_CFG_LOCAL command. In that case, it skips core 
temperature group creation and supports only basic temperature 
monitoring of Die, DTS margin and etc. I'll add this description as a 
comment.

>> +
>> +	priv->chip.ops = &cputemp_ops;
>> +	priv->chip.info = priv->info;
>> +
>> +	priv->info[0] = &priv->temp_info;
>> +
>> +	priv->temp_info.type = hwmon_temp;
>> +	priv->temp_info.config = priv->temp_config;
>> +
>> +	hwmon_dev = devm_hwmon_device_register_with_info(priv->dev,
>> +							 priv->name,
>> +							 priv,
>> +							 &priv->chip,
>> +							 NULL);
>> +
>> +	if (IS_ERR(hwmon_dev))
>> +		return PTR_ERR(hwmon_dev);
>> +
>> +	dev_dbg(dev, "%s: sensor '%s'\n", dev_name(hwmon_dev), priv->name);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id peci_cputemp_of_table[] = {
>> +	{ .compatible = "intel,peci-cputemp" },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, peci_cputemp_of_table);
>> +
>> +static struct peci_driver peci_cputemp_driver = {
>> +	.probe  = peci_cputemp_probe,
>> +	.driver = {
>> +		.name           = "peci-cputemp",
>> +		.of_match_table = of_match_ptr(peci_cputemp_of_table),
>> +	},
>> +};
>> +module_peci_driver(peci_cputemp_driver);
>> +
>> +MODULE_AUTHOR("Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>");
>> +MODULE_DESCRIPTION("PECI cputemp driver");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/hwmon/peci-dimmtemp.c b/drivers/hwmon/peci-dimmtemp.c
>> new file mode 100644
>> index 000000000000..78bf29cb2c4c
>> --- /dev/null
>> +++ b/drivers/hwmon/peci-dimmtemp.c
> 
> FWIW, this should be two separate patches.
> 

Should I split out hwmon documents and dt bindings too?

>> @@ -0,0 +1,432 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (c) 2018 Intel Corporation
>> +
>> +#include <linux/delay.h>
>> +#include <linux/hwmon.h>
>> +#include <linux/hwmon-sysfs.h>
> 
> Needed ?
> 

No. Will drop the line.

>> +#include <linux/jiffies.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <linux/peci.h>
>> +#include <linux/workqueue.h>
>> +
>> +#define TEMP_TYPE_PECI       6  /* Sensor type 6: Intel PECI */
>> +
>> +#define CHAN_RANK_MAX_ON_HSX 8  /* Max number of channel ranks on Haswell */
>> +#define DIMM_IDX_MAX_ON_HSX  3  /* Max DIMM index per channel on Haswell */
>> +
>> +#define CHAN_RANK_MAX_ON_BDX 4  /* Max number of channel ranks on Broadwell */
>> +#define DIMM_IDX_MAX_ON_BDX  3  /* Max DIMM index per channel on Broadwell */
>> +
>> +#define CHAN_RANK_MAX_ON_SKX 6  /* Max number of channel ranks on Skylake */
>> +#define DIMM_IDX_MAX_ON_SKX  2  /* Max DIMM index per channel on Skylake */
>> +
>> +#define CHAN_RANK_MAX        CHAN_RANK_MAX_ON_HSX
>> +#define DIMM_IDX_MAX         DIMM_IDX_MAX_ON_HSX
>> +
>> +#define DIMM_NUMS_MAX        (CHAN_RANK_MAX * DIMM_IDX_MAX)
>> +
>> +#define CLIENT_CPU_ID_MASK   0xf0ff0  /* Mask for Family / Model info */
>> +
>> +#define UPDATE_INTERVAL_MIN  HZ
>> +
>> +#define DIMM_MASK_CHECK_DELAY_JIFFIES msecs_to_jiffies(5000)
>> +#define DIMM_MASK_CHECK_RETRY_MAX     60 /* 60 x 5 secs = 5 minutes */
>> +
>> +enum cpu_gens {
>> +	CPU_GEN_HSX, /* Haswell Xeon */
>> +	CPU_GEN_BRX, /* Broadwell Xeon */
>> +	CPU_GEN_SKX, /* Skylake Xeon */
>> +	CPU_GEN_MAX
>> +};
>> +
>> +struct cpu_gen_info {
>> +	u32 type;
>> +	u32 cpu_id;
>> +	u32 chan_rank_max;
>> +	u32 dimm_idx_max;
>> +};
>> +
>> +struct temp_data {
>> +	bool valid;
>> +	s32  value;
>> +	unsigned long last_updated;
>> +};
>> +
>> +struct peci_dimmtemp {
>> +	struct peci_client *client;
>> +	struct device *dev;
>> +	struct workqueue_struct *work_queue;
>> +	struct delayed_work work_handler;
>> +	char name[PECI_NAME_SIZE];
>> +	struct temp_data temp[DIMM_NUMS_MAX];
>> +	u8 addr;
>> +	uint cpu_no;
>> +	const struct cpu_gen_info *gen_info;
>> +	u32 dimm_mask;
>> +	int retry_count;
>> +	int channels;
>> +	u32 temp_config[DIMM_NUMS_MAX + 1];
>> +	struct hwmon_channel_info temp_info;
>> +	const struct hwmon_channel_info *info[2];
>> +	struct hwmon_chip_info chip;
>> +};
>> +
>> +static const struct cpu_gen_info cpu_gen_info_table[] = {
>> +	{ .type  = CPU_GEN_HSX,
>> +	  .cpu_id = 0x306f0, /* Family code: 6, Model number: 63 (0x3f) */
>> +	  .chan_rank_max = CHAN_RANK_MAX_ON_HSX,
>> +	  .dimm_idx_max  = DIMM_IDX_MAX_ON_HSX },
>> +	{ .type  = CPU_GEN_BRX,
>> +	  .cpu_id = 0x406f0, /* Family code: 6, Model number: 79 (0x4f) */
>> +	  .chan_rank_max = CHAN_RANK_MAX_ON_BDX,
>> +	  .dimm_idx_max  = DIMM_IDX_MAX_ON_BDX },
>> +	{ .type  = CPU_GEN_SKX,
>> +	  .cpu_id = 0x50650, /* Family code: 6, Model number: 85 (0x55) */
>> +	  .chan_rank_max = CHAN_RANK_MAX_ON_SKX,
>> +	  .dimm_idx_max  = DIMM_IDX_MAX_ON_SKX },
>> +};
>> +
>> +static const char *dimmtemp_label[CHAN_RANK_MAX][DIMM_IDX_MAX] = {
>> +	{ "DIMM A0", "DIMM A1", "DIMM A2" },
>> +	{ "DIMM B0", "DIMM B1", "DIMM B2" },
>> +	{ "DIMM C0", "DIMM C1", "DIMM C2" },
>> +	{ "DIMM D0", "DIMM D1", "DIMM D2" },
>> +	{ "DIMM E0", "DIMM E1", "DIMM E2" },
>> +	{ "DIMM F0", "DIMM F1", "DIMM F2" },
>> +	{ "DIMM G0", "DIMM G1", "DIMM G2" },
>> +	{ "DIMM H0", "DIMM H1", "DIMM H2" },
>> +};
>> +
>> +static int send_peci_cmd(struct peci_dimmtemp *priv, enum peci_cmd cmd,
>> +			 void *msg)
>> +{
>> +	return peci_command(priv->client->adapter, cmd, msg);
>> +}
>> +
>> +static int need_update(struct temp_data *temp)
>> +{
>> +	if (temp->valid &&
>> +	    time_before(jiffies, temp->last_updated + UPDATE_INTERVAL_MIN))
>> +		return 0;
>> +
>> +	return 1;
>> +}
>> +
>> +static void mark_updated(struct temp_data *temp)
>> +{
>> +	temp->valid = true;
>> +	temp->last_updated = jiffies;
>> +}
> 
> It might make sense to provide the duplicate functions in a core file.
> 

It is temperature monitoring specific function and it touches module 
specific variables. Do you really think that this non-generic function 
should be moved to PECI core?

>> +
>> +static int get_dimm_temp(struct peci_dimmtemp *priv, int dimm_no)
>> +{
>> +	int dimm_order = dimm_no % priv->gen_info->dimm_idx_max;
>> +	int chan_rank = dimm_no / priv->gen_info->dimm_idx_max;
>> +	struct peci_rd_pkg_cfg_msg msg;
>> +	int rc;
>> +
>> +	if (!need_update(&priv->temp[dimm_no]))
>> +		return 0;
>> +
>> +	msg.addr = priv->addr;
>> +	msg.index = MBX_INDEX_DDR_DIMM_TEMP;
>> +	msg.param = chan_rank;
>> +	msg.rx_len = 4;
>> +
>> +	rc = send_peci_cmd(priv, PECI_CMD_RD_PKG_CFG, &msg);
>> +	if (rc)
>> +		return rc;
>> +
>> +	priv->temp[dimm_no].value = msg.pkg_config[dimm_order] * 1000;
>> +
>> +	mark_updated(&priv->temp[dimm_no]);
>> +
>> +	return 0;
>> +}
>> +
>> +static int find_dimm_number(struct peci_dimmtemp *priv, int channel)
>> +{
>> +	int dimm_nums_max = priv->gen_info->chan_rank_max *
>> +			    priv->gen_info->dimm_idx_max;
>> +	int idx, found = 0;
>> +
>> +	for (idx = 0; idx < dimm_nums_max; idx++) {
>> +		if (priv->dimm_mask & BIT(idx)) {
>> +			if (channel == found)
>> +				break;
>> +
>> +			found++;
>> +		}
>> +	}
>> +
>> +	return idx;
>> +}
> 
> This again looks like duplicate code.
> 

find_dimm_number()? I'm sure it isn't.

>> +
>> +static int dimmtemp_read_string(struct device *dev,
>> +				enum hwmon_sensor_types type,
>> +				u32 attr, int channel, const char **str)
>> +{
>> +	struct peci_dimmtemp *priv = dev_get_drvdata(dev);
>> +	u32 dimm_idx_max = priv->gen_info->dimm_idx_max;
>> +	int dimm_no, chan_rank, dimm_idx;
>> +
>> +	switch (attr) {
>> +	case hwmon_temp_label:
>> +		dimm_no = find_dimm_number(priv, channel);
>> +		chan_rank = dimm_no / dimm_idx_max;
>> +		dimm_idx = dimm_no % dimm_idx_max;
>> +		*str = dimmtemp_label[chan_rank][dimm_idx];
>> +		return 0;
>> +	default:
>> +		return -EOPNOTSUPP;
>> +	}
>> +}
>> +
>> +static int dimmtemp_read(struct device *dev, enum hwmon_sensor_types type,
>> +			 u32 attr, int channel, long *val)
>> +{
>> +	struct peci_dimmtemp *priv = dev_get_drvdata(dev);
>> +	int dimm_no = find_dimm_number(priv, channel);
>> +	int rc;
>> +
>> +	switch (attr) {
>> +	case hwmon_temp_input:
>> +		rc = get_dimm_temp(priv, dimm_no);
>> +		if (rc)
>> +			return rc;
>> +
>> +		*val = priv->temp[dimm_no].value;
>> +		return 0;
>> +	default:
>> +		return -EOPNOTSUPP;
>> +	}
>> +}
>> +
>> +static umode_t dimmtemp_is_visible(const void *data,
>> +				   enum hwmon_sensor_types type,
>> +				   u32 attr, int channel)
>> +{
>> +	switch (attr) {
>> +	case hwmon_temp_label:
>> +	case hwmon_temp_input:
>> +		return 0444;
>> +	default:
>> +		return 0;
>> +	}
>> +}
>> +
>> +static const struct hwmon_ops dimmtemp_ops = {
>> +	.is_visible = dimmtemp_is_visible,
>> +	.read_string = dimmtemp_read_string,
>> +	.read = dimmtemp_read,
>> +};
>> +
>> +static int check_populated_dimms(struct peci_dimmtemp *priv)
>> +{
>> +	u32 chan_rank_max = priv->gen_info->chan_rank_max;
>> +	u32 dimm_idx_max = priv->gen_info->dimm_idx_max;
>> +	struct peci_rd_pkg_cfg_msg msg;
>> +	int chan_rank, dimm_idx;
>> +	int rc, channels = 0;
>> +
>> +	for (chan_rank = 0; chan_rank < chan_rank_max; chan_rank++) {
>> +		msg.addr = priv->addr;
>> +		msg.index = MBX_INDEX_DDR_DIMM_TEMP;
>> +		msg.param = chan_rank;
>> +		msg.rx_len = 4;
>> +
>> +		rc = send_peci_cmd(priv, PECI_CMD_RD_PKG_CFG, &msg);
>> +		if (rc) {
>> +			priv->dimm_mask = 0;
>> +			return rc;
>> +		}
>> +
>> +		for (dimm_idx = 0; dimm_idx < dimm_idx_max; dimm_idx++) {
>> +			if (msg.pkg_config[dimm_idx]) {
>> +				priv->dimm_mask |= BIT(chan_rank *
>> +						       chan_rank_max +
>> +						       dimm_idx);
>> +				channels++;
>> +			}
>> +		}
>> +	}
>> +
>> +	if (!priv->dimm_mask)
>> +		return -EAGAIN;
>> +
>> +	priv->channels = channels;
>> +
>> +	dev_dbg(priv->dev, "Scanned populated DIMMs: 0x%x\n", priv->dimm_mask);
>> +	return 0;
>> +}
>> +
>> +static int create_dimm_temp_info(struct peci_dimmtemp *priv)
>> +{
>> +	struct device *hwmon_dev;
>> +	int rc, i;
>> +
>> +	rc = check_populated_dimms(priv);
>> +	if (!rc) {
> 
> Please handle error cases first.
> 

Sure, I'll rewrite it.

>> +		for (i = 0; i < priv->channels; i++)
>> +			priv->temp_config[i] = HWMON_T_LABEL | HWMON_T_INPUT;
>> +
>> +		priv->chip.ops = &dimmtemp_ops;
>> +		priv->chip.info = priv->info;
>> +
>> +		priv->info[0] = &priv->temp_info;
>> +
>> +		priv->temp_info.type = hwmon_temp;
>> +		priv->temp_info.config = priv->temp_config;
>> +
>> +		hwmon_dev = devm_hwmon_device_register_with_info(priv->dev,
>> +								 priv->name,
>> +								 priv,
>> +								 &priv->chip,
>> +								 NULL);
>> +		rc = PTR_ERR_OR_ZERO(hwmon_dev);
>> +		if (!rc)
>> +			dev_dbg(priv->dev, "%s: sensor '%s'\n",
>> +				dev_name(hwmon_dev), priv->name);
>> +	} else if (rc == -EAGAIN) {
>> +		if (priv->retry_count < DIMM_MASK_CHECK_RETRY_MAX) {
>> +			queue_delayed_work(priv->work_queue,
>> +					   &priv->work_handler,
>> +					   DIMM_MASK_CHECK_DELAY_JIFFIES);
>> +			priv->retry_count++;
>> +			dev_dbg(priv->dev,
>> +				"Deferred DIMM temp info creation\n");
>> +		} else {
>> +			rc = -ETIMEDOUT;
>> +			dev_err(priv->dev,
>> +				"Timeout retrying DIMM temp info creation\n");
>> +		}
>> +	}
>> +
>> +	return rc;
>> +}
>> +
>> +static void create_dimm_temp_info_delayed(struct work_struct *work)
>> +{
>> +	struct delayed_work *dwork = to_delayed_work(work);
>> +	struct peci_dimmtemp *priv = container_of(dwork, struct peci_dimmtemp,
>> +						  work_handler);
>> +	int rc;
>> +
>> +	rc = create_dimm_temp_info(priv);
>> +	if (rc && rc != -EAGAIN)
>> +		dev_dbg(priv->dev, "Failed to create DIMM temp info\n");
>> +}
>> +
>> +static int check_cpu_id(struct peci_dimmtemp *priv)
>> +{
>> +	struct peci_rd_pkg_cfg_msg msg;
>> +	u32 cpu_id;
>> +	int i, rc;
>> +
>> +	msg.addr = priv->addr;
>> +	msg.index = MBX_INDEX_CPU_ID;
>> +	msg.param = PKG_ID_CPU_ID;
>> +	msg.rx_len = 4;
>> +
>> +	rc = send_peci_cmd(priv, PECI_CMD_RD_PKG_CFG, &msg);
>> +	if (rc)
>> +		return rc;
>> +
>> +	cpu_id = ((msg.pkg_config[2] << 16) | (msg.pkg_config[1] << 8) |
>> +		  msg.pkg_config[0]) & CLIENT_CPU_ID_MASK;
>> +
>> +	for (i = 0; i < CPU_GEN_MAX; i++) {
>> +		if (cpu_id == cpu_gen_info_table[i].cpu_id) {
>> +			priv->gen_info = &cpu_gen_info_table[i];
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (!priv->gen_info)
>> +		return -ENODEV;
>> +
>> +	dev_dbg(priv->dev, "CPU_ID: 0x%x\n", cpu_id);
>> +	return 0;
>> +}
> 
> More duplicate code.
> 

Okay. In case of check_cpu_id(), it could be used as a generic PECI 
function. I'll move it into PECI core.

>> +
>> +static int peci_dimmtemp_probe(struct peci_client *client)
>> +{
>> +	struct device *dev = &client->dev;
>> +	struct peci_dimmtemp *priv;
>> +	int rc;
>> +
>> +	if ((client->adapter->cmd_mask &
>> +	    (BIT(PECI_CMD_GET_TEMP) | BIT(PECI_CMD_RD_PKG_CFG))) !=
>> +	    (BIT(PECI_CMD_GET_TEMP) | BIT(PECI_CMD_RD_PKG_CFG))) {
> 
> One set of ( ) is unnecessary on each side of the expression.
> 

'&' has a precedence over '!=' but '|' doesn't. I'll rewrite it to:

	if (client->adapter->cmd_mask &
	    (BIT(PECI_CMD_GET_TEMP) | BIT(PECI_CMD_RD_PKG_CFG)) !=
	    (BIT(PECI_CMD_GET_TEMP) | BIT(PECI_CMD_RD_PKG_CFG)))

>> +		dev_err(dev, "Client doesn't support temperature monitoring\n");
>> +		return -EINVAL;
> 
> Why is this "invalid", and why does it warrant an error message ?
> 

Should I use -EPERM? Any suggestion?

>> +	}
>> +
>> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	dev_set_drvdata(dev, priv);
>> +	priv->client = client;
>> +	priv->dev = dev;
>> +	priv->addr = client->addr;
>> +	priv->cpu_no = priv->addr - PECI_BASE_ADDR;
> 
> Is priv->addr guaranteed to be >= PECI_BASE_ADDR ?

Client address range validation will be done in 
peci_check_addr_validity() in PECI core before probing a device driver.

>> +
>> +	snprintf(priv->name, PECI_NAME_SIZE, "peci_dimmtemp.cpu%d",
>> +		 priv->cpu_no);
>> +
>> +	rc = check_cpu_id(priv);
>> +	if (rc) {
>> +		dev_err(dev, "Client CPU is not supported\n");
> 
> Or the peci command failed.
> 

I'll remove the error message and will add a proper handling code into 
PECI core on each error type.

>> +		return rc;
>> +	}
>> +
>> +	priv->work_queue = alloc_ordered_workqueue(priv->name, 0);
>> +	if (!priv->work_queue)
>> +		return -ENOMEM;
>> +
>> +	INIT_DELAYED_WORK(&priv->work_handler, create_dimm_temp_info_delayed);
>> +
>> +	rc = create_dimm_temp_info(priv);
>> +	if (rc && rc != -EAGAIN) {
>> +		dev_err(dev, "Failed to create DIMM temp info\n");
>> +		goto err_free_wq;
>> +	}
>> +
>> +	return 0;
>> +
>> +err_free_wq:
>> +	destroy_workqueue(priv->work_queue);
>> +	return rc;
>> +}
>> +
>> +static int peci_dimmtemp_remove(struct peci_client *client)
>> +{
>> +	struct peci_dimmtemp *priv = dev_get_drvdata(&client->dev);
>> +
>> +	cancel_delayed_work(&priv->work_handler);
> 
> cancel_delayed_work_sync() ?
> 

Yes, it would be safer. Will fix it.

>> +	destroy_workqueue(priv->work_queue);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id peci_dimmtemp_of_table[] = {
>> +	{ .compatible = "intel,peci-dimmtemp" },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, peci_dimmtemp_of_table);
>> +
>> +static struct peci_driver peci_dimmtemp_driver = {
>> +	.probe  = peci_dimmtemp_probe,
>> +	.remove = peci_dimmtemp_remove,
>> +	.driver = {
>> +		.name           = "peci-dimmtemp",
>> +		.of_match_table = of_match_ptr(peci_dimmtemp_of_table),
>> +	},
>> +};
>> +module_peci_driver(peci_dimmtemp_driver);
>> +
>> +MODULE_AUTHOR("Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>");
>> +MODULE_DESCRIPTION("PECI dimmtemp driver");
>> +MODULE_LICENSE("GPL v2");
>> -- 
>> 2.16.2
>>
