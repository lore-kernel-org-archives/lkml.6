Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752648AbeDRJio (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 05:38:44 -0400
Received: from mail-sn1nam02on0061.outbound.protection.outlook.com ([104.47.36.61]:39232
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751210AbeDRJim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 05:38:42 -0400
Subject: Re: [PATCH 1/4] ASoC: dwc: I2S Controller instance param added
To: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>, Lubomir Rintel <lkundrak@v3.sk>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1523941201-15665-1-git-send-email-Vijendar.Mukunda@amd.com>
 <1523941201-15665-2-git-send-email-Vijendar.Mukunda@amd.com>
 <20180417160908.GH8973@sirena.org.uk>
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Message-ID: <88fc41f1-79ee-5df1-3a23-e188c83c9d42@amd.com>
Date: Wed, 18 Apr 2018 15:11:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180417160908.GH8973@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [125.21.194.1]
X-ClientProxiedBy: BM1PR01CA0095.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::11)
 To SN1PR12MB0317.namprd12.prod.outlook.com (2a01:111:e400:5146::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0317;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0317;3:bFFKRPWUWj7ajEgkgQh1dLt74CXQ+WliPe43ISAWfSaaXUdrzVtpdEwg/3JgKhHOW72YaoGEhA1MnpAQMixs4jK3mMy1puiiDt55sO940LiQ3H8kpydyhVvDgboYhl8g9OM+FdeWRqKSwNprRw/0/8/LZEyeb9k6R0cTeY45r+qFy97b12M4rH9/LaMepS7nFBTro/U3AxLLtxdBdrB5ED8xep1iQUo8DxcNeLFS2TWx2zdzVKaIDRpW4lKtZO27;25:y2jI5y4n5JaFBJv/FAifwfpoNrhaETB3WqmJBJo9/nI6U8aQL+AniZqvPlgGdiNzFVzpPi3B1gwP/yHKuYQqRP8SkWfZL47RIGjPd3ne91skBtQdwj6STIhtqKeuZ/qiEEVl+GX6EVrDaWDkXKEEhx1qjXB+2oKIWrnk+ucAWOcGGbRXyQ+U6qaF2hW/FvgV+hoUJ40R+0fG6JqKXPinw/oHWEEF6es4wrRbIwf54PXbAVlNTCcqZKKFxeqRYE4mbOcPE0nwS9ykqbZaG8GZlKreVjrgQ0CDX6cdpcjFp8OBBupwxd2LzZwe5eyLafVXkQHKSOdTJDT+gXmERFUIkQ==;31:l135w+ByUVvN9Dz7+JWXP9D988rb0LA7nUpr6UoUUHbkuWlp3FxQ+ZhOjKsYVhx4uzPlbZaQBG4z32ED6PKd/4ly4gcngL3l4R4EGv2h/wt5LVOMpYAhaDuvMK+g57y/DMKvrz/3S8MMt+tEgsCFVPtTAOeLwXusc0vOW/ZWujc/HG/uFAd2wBuMkA5DPvUO4VkgmRWNAJb7NO/kV/sk/CHNFz2Yl5GrZ1o7cNcM3Tg=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0317:
Authentication-Results: outbound.protection.outlook.com; spf=skipped
 (originating message); dkim=none (message not signed) header.d=none;
 dmarc=none action=none header.from=amd.com;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0317;20:jaefIuLfWhCq5sULNi070bjSzbkNlCZz1C2sBG8qKo90bY9gi+QWZli48OP/GdX/OxFJxu3dkz89zCU2YKQD9ySXrIwPi+Du9PCukvbgynR7RLW5Ot9e5KetJaNOX7tYvvAzA/fQhSqKjUrmZKcF9Glr2dGuwSME+blq+f3DyoZVzG6DLwTeUocRHhIhQXE1Dq67OiaucjiayIXQo3TQYlqAtl/zYH/BRQfOhXAUpjZjBqULI04ZSKJ76ZcspA3/M2xfgg7cIJUvLgLvNdbic73TLDatS+YbQwAtCU0Q1QuRHbutK6fOvOfLfb/Zcy7roJ55s+i5aPGrHkrMkPOA0DeCF1FpgvmWZDrMgPPrF79pX535r8bnaAgS7cY+sHmx8HKKn0N3Xrmp3rHsNwLiHz0Z7fqUF9ivE5B9iEUppV4PSEgPIR2QdrLHWnAMjBLr5rJwQBeLRGunMM6dE1memADB6t0D5HdCxaKrEzDlhk6YEBGrwb+0hG4UVD5MEUiO;4:66EdnMTkF6iqtL88bBsiWx57Hvfe6Y1VsBTnEhViJmaR35S9fSy6SUC1ngMrkDUDVbTEOL6DrsIQfKvhZ9FemcAiqXtPJIU9cJd9souNQEIS5G9Wwf5nHmdtCAynCb5AhmVtDhExZj5aQYbx+l8TO82UgjKd3Hh1RhY21+zkJ3yh1dK44eIjaphNIoqOSjfTwEscuuoVg4T3KHijo9cswzBNuhdvxu+vZ+gQOBl1/07G35crysYtAJTr68ujKUCSPl3hE6hsfRwZvwqj1zA+og==
X-Microsoft-Antispam-PRVS: <SN1PR12MB0317DAC4A78D953AF69D191897B60@SN1PR12MB0317.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231232)(944501368)(52105095)(6055026)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:SN1PR12MB0317;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0317;
X-Forefront-PRVS: 06469BCC91
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(376002)(396003)(39380400002)(366004)(346002)(446003)(52116002)(11346002)(386003)(2616005)(26005)(2906002)(186003)(86362001)(97736004)(4326008)(956004)(31686004)(77096007)(230700001)(50466002)(476003)(16526019)(67846002)(64126003)(31696002)(6116002)(478600001)(47776003)(65826007)(305945005)(66066001)(8676002)(81166006)(54906003)(23746002)(6246003)(3846002)(39060400002)(316002)(5660300001)(58126008)(72206003)(7416002)(7736002)(6916009)(16576012)(6486002)(6666003)(8936002)(25786009)(65956001)(65806001)(76176011)(229853002)(36756003)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0317;H:[10.129.12.246];FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;SN1PR12MB0317;23:yQ4ZWdkZ4tGY0J5uSAV2ob3DpqiDF3VknIE+b?=
 =?Windows-1252?Q?MFi50DMmGNoAJhWY5KFLex+um0mZ0kgy0teuGVhY8lm7wFXHOzi3QIEA?=
 =?Windows-1252?Q?/b7ZmjPBtPooN9wc48bnh71N8uh7xPbiB+NEV39NwyGa4sR6pfU++c6/?=
 =?Windows-1252?Q?4H43EX+Hh/XoEzPdGKw0rpd9Sph361x835/wT0RGDbLp37YnUSohAMlm?=
 =?Windows-1252?Q?rs1H+KTiofbD4CDyoKcKs9FzAnjiBdIE770tDXeC1NGziKY3K+eS0Ahj?=
 =?Windows-1252?Q?CgWr+KvigbeG/yWYKAE36zHFM1+B6iFO9GSzsQfi3givPLxgr8L6Q48H?=
 =?Windows-1252?Q?JwXyOamtHNrBiPhVZsJRvKG0vlDlJ1FXTRFzUjRefk9AN2UEGLcsongI?=
 =?Windows-1252?Q?bKWQH2KsWngsm87yJEEJxwAe9j0a7XHBKTxm4gYnfV1h42wOjaazTsTj?=
 =?Windows-1252?Q?WF5i70v6H1IvWMpY+VrzEXCcp4DUbahckAD+lXFx5aniUJxsIXHq0UEr?=
 =?Windows-1252?Q?1Je93qf+i7a/+37f5gCNvPfVV3j8I3UApZMHzoOX5bYsU1fjB3UQ3tRv?=
 =?Windows-1252?Q?0++Z53zuQOM7SUa1zXpqGU6jnMTTBLqNyQjHT/AUDfGkSDSTWLbzTbSz?=
 =?Windows-1252?Q?HV7wJQXBs+3tsnkHy1VBkoRr8FOP6li8HzI2sSzYscMji1eKF6isnIfr?=
 =?Windows-1252?Q?fQwwwPNCMFEVB+0GkK9PdoLozfZWlxI1WYS/oPn//E4+RHbI8xHOlKIJ?=
 =?Windows-1252?Q?VtxMrDLOFu0qmQSAk+WwQQEn8ec3ZubEN163M+p963oiOoM4+pdKDzyE?=
 =?Windows-1252?Q?RMBt6ButW6Vpa2h5vwf7YJikSl5BSdvAyLmvdtQdpQ2ETjnnM69bqw/y?=
 =?Windows-1252?Q?Gtcn1SKHhg8rtt/DAVrJhRwEAnZnvKgdTNqnYZqq74vx3SaGFZ0z+K8h?=
 =?Windows-1252?Q?eYzrtC7Xwhc+8+nG5SK2CIwHioOO22joYNxuNnwe9fKLlC8NZm/RMz2n?=
 =?Windows-1252?Q?4O29AZhhGS6qpXgBOyu3fK2S7gwM27ThwECs68jWI32Aag0oVlNiUYjF?=
 =?Windows-1252?Q?MCYNsLjd97aCX2+icLgYl0sAAKY7Zu8hrA2t45Qnoy1jDWlClxA9umZ8?=
 =?Windows-1252?Q?S9dMGZI/qiYhSslZ+BdiwJMH5Lc0TGFcZqrt3nCr/3yR7N4+7BxcB+04?=
 =?Windows-1252?Q?9DQSFUeen3pwoLlTIKEN6ANd3XM4WKnZnOG7TbsfbL5qJxX21lZhvd+E?=
 =?Windows-1252?Q?9SgHZSr9zIzKaf23D/Mmt1l1oIHvEyqRtg0wQqwKpLCEWBr0iQ+jm+uq?=
 =?Windows-1252?Q?A/EnIRCxFKtCsL/GjvmexhsHUyRZzxnp/KkEsemKkpU2NO2o/jRda0qN?=
 =?Windows-1252?Q?eP2GpvHLn595h5JIWIAdoY6Q0yc/GCvOsZbgIVh2YREviPyU/OAF/356?=
 =?Windows-1252?Q?3WOEkuCZS8JtCg7RsWW?=
X-Microsoft-Antispam-Message-Info: nST4LlBWr16EcBkMBYJU0L6F16Xs5J+go5zIEMRoUGZHnVrd+mnppcGSNVlA/JMKdSNTt+/vmpS/cGMVDmJwxjqp4pHpyaSBFnrMRAHI/na2gY0yuIsgxIxQBWY8hpagsC5f3BGjyj1EmRp1i9ni2IobLI1NkpmfQmBfiDusjs5Mf6/5TXSdQlVpGl/EwLwL
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0317;6:v5IyY+k1dv9GGZ5NSXbue26tZ4ZBZ2ug5RMpZez/8REN8XyRBgta1W5z6usMj5b2ICgZ+onu2CeUnMefO1OV/N7onAxT/dfsxkLmW53h2hXDZ16b96mwzxWG6VWcQ2eILh69j97KZ+ML3j864vwBC+RDi4ZTz+z3tQXZJRomynMcvWQyN38guUaKiGCQKS59xXJSSsFNYa1EXcIVpHCdPc4IWAcCt4ZizVGrw10CTXXiZ/lNEOInDu9JP9l//0iMIccI1sXuUJQyY69MhM8TttRQdvPyGxRcT0XnN/A5dJlqm65boyKO0QMBtHpXaPYYiDTXe4ONlnF8ZblL7cW224lRT9kSemVxGiTI04aheo26/oPSPWAI9S5h1Zmlt4fTuoJU0GLv2At8/L1z742TU5U6aHHm4yegMdYrTG1dMRNy5v53evFkSRvFpPEZkM1R0OPo3qWJKyRAMtI2dHsQvg==;5:hW2W0VhP2M+PnLtw4s9x2UugAs0RlFTbjHWMR153YNjATEUGq6CBAelAl8x+7dySRr5pf7wtWsFts0FqtONhtPSz78kI+8D6UxUdi0bwyl4O04+VkS+c3nkxTtAkw5Tao7NHJEIvT2U8S7ozizCv++BJCMMG7Aj+6DMN1yAFfgI=;24:hcWoUnKfx8GSMj9clVO6lBOsgytoBoSet2LAtqXPXi9sfolt/u1rqL278UfWMtYAy5ZLtyrLsn0+nQ0nFMLj47DCyNy8BG2eKvWJx8v1l+0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0317;7:6zNz2PpqKlzB73a/w9DMkwO55j/KXqmGrRONTfUdJfz6cemcc8WKIUKZ6w+q2h5X0UalkwgK4T7SkkS/AwTFhzuJrXvzCdnDozr+xWe3Eq/lj7Nq0mqeC/xKqivMWCKg03aFiahW/oZ/gijOGqCJczGTrfGljKByZtM2Ml8lJu+qYABtvIy2ACl+CZbyQi2wdd8BQ0QDkA48LOzqsBVsq0fXuFKj+4b+qGqTHD7Z+h5lV71NR7EUnsifLFPdj1VK;20:v+CF1c1vn6553svSKfS2hElA7pg/O7qtdwRWdn2Z9Snvoa8rloaFrcp3/vtvnIlODJsPLUEdRCfrEY7/xZKeThDpNVCl30YYmFuEwxcuHdcudesJQoXHrl5gXFawznJ8Zzy8uswDGD00fciIJtWD1oFqI/TRc7W4MOoQBDZX9IBodT9/RdxEVMM7dti3l3fwjF94aBa6uJ/TCuTHgN8PX8XvwjZfwlnZfN+sODb5+/PWdkXcUFLsnOdzzMXRBXgA
X-MS-Office365-Filtering-Correlation-Id: 9b53f703-e20d-4d62-cf67-08d5a5102ae5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2018 09:38:36.2119 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b53f703-e20d-4d62-cf67-08d5a5102ae5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0317
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday 17 April 2018 09:39 PM, Mark Brown wrote:
> On Tue, Apr 17, 2018 at 10:29:51AM +0530, Vijendar Mukunda wrote:
> 
>> +#define I2S_SP_INSTANCE		1
>> +#define I2S_BT_INSTANCE		2
> 
> This is obviously very specific to the system you're working with and
> therefore doesn't belong in the generic driver.  The device should be
> dealing with its own configuration, it shouldn't need to know about what
> specifically is connected to it.  It's not even clear what they're doing
> in this driver given that there doesn't appear to be any use of the
> information, it feels like this is something that the machine driver
> should be encapsulating.
> 
> Like I said with previous reviews this use of magic numbers for the
> interfaces is a bit of a red flag, internally within a driver they're
> fine but they shouldn't leak out too much except with things like
> numbering an array.
> 

I will remove macros from designware header file and I will re spin
the patch set
