Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751951AbeCVPnc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 11:43:32 -0400
Received: from mail-sn1nam02on0072.outbound.protection.outlook.com ([104.47.36.72]:43918
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751903AbeCVPnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 11:43:24 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: [PATCH][next] drm/amdgpu: fix spelling mistake: "asssert" ->
 "assert"
To: Colin King <colin.king@canonical.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        "monk.liu" <monk.liu@amd.com>
References: <20180322154144.31363-1-colin.king@canonical.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <0ddcfc5a-e15c-5b01-bce3-17d0673bb4fb@amd.com>
Date: Thu, 22 Mar 2018 16:43:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180322154144.31363-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: DB6PR0202CA0018.eurprd02.prod.outlook.com
 (2603:10a6:4:29::28) To MWHPR12MB1725.namprd12.prod.outlook.com
 (2603:10b6:300:112::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 80596678-3978-4d6b-a1a9-08d5900ba48b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:MWHPR12MB1725;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1725;3:XCx5CXGJTQMidaPW5xEH5wuRoGX77Rz8k23KAOynOLeoYY+/fawjMJrO7FYJF7H6L3P0c2JJWP28Vp4X0R+F7QryfAvySP7YAXlCGLFdEsytyqrO5v7MsK0cYOrnQjr8jbN9OBriABQ6UwonuY7aAYT7A5djqqf9glXt0VT/i2DiwXCHEqdiLaQXox2XgTYaC3FypuuN8wiInfng6R4SbV5sQ5csdaFywlHUHZF7HLrUsoiIsdOwepAursTghdO0;25:GW1TK5OF6WXhVSIfgQb8BD5e2IxnZYJlwRH4B5k3WR4EOnsyaurwoswPcSRr0QEMIdp/ZV+rGPMcrSVp2cOW3cR0yxXULjudUEd3nkiL4K3zErGRqHHwKp48idbzHX4e1YrKnBl+j4zRrRPaDST/FDtY7jKRCrvlNoY0asINFpoUpIineY0XDZgoXYksgN6M8PEaP6HBmbHRM6hJo4AfxdwjG0/D+bpyNKjgORzg9fcAIEBOfPrdxwA/sPALisXT8PmLp2tolW4zPmMk+NqSe8b0cGMzJsd4fjYCNjLqnO3sXr5lcyVn2jcPiaasvrU/BHiBXQex3U+ZDDSLW6Q2lg==;31:oHDMUoW9Y+aM5xSmGz+IAr7jaX8hbmpoXo2cfeVIcBPTSRH+A/m0rpHdcg6aW+p7ej7V+FiIies63DXzRCNk4NEYi9IrxfBE0VEOiTyzxolVrimwDSr9qC0aXoLeLsLLRwGwQ7MhcmJ2t2AF6EJr7xZjGYL9CmSCkGN7jrfHWSBmg8YMZarOAtKpui9O5/P0Ugfm4oKxrM1ZMHD8lruK+2N+ph7GdJ4JorkU+9aQo14=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1725:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1725;20:6JtvNkKLphv0RH+UE809wYSYVFFxSLgG/UVeaWmWP5sg1EI7VIapPLKm3hTUNjxz2DAzL+UsG8PSowBzMPR539tzaZJ/oYb78LpgZRjel8OjodQFTJLUiMpEK9mLwlZWfKngoK5S/b06ZAnLPWZBqcUcsNTdjHYNdhyWZxf3FRTDBWHDEFHbFyidI6Ptlu718B2hyE2bq6JXccFgeMNXCFhwNXVKJEYjY6ad7/T1Ah/RlKMXXNL9Q+nFvKWu6z2GSdf1IlioeZcygyvoTStg8dX0/WHMyIj4QbNCONCQGv1qB17om19EkoWUqLbNc+tyXqvEbcmovsWK0/w73/X4eoPSV/OYWDXwRLEoGdzpIxzJLp1gn+tLQzMettzA3ij8iji3x26WkY8E/EWpSu40vChn56uyu62AVkfXA1zxM8gYLTex1hldB9QLE1n+PW/JBZzFunNa+rQanVKoubgITYjZZ9Lv3jzjbmOCCazBOHWwqZ0EpRL51G6+oYXuNSoJ;4:AvhtvjU+xVaPVYQ9xRnfDGIZUcBMSsBHjPorutEzmDKtg9hwbDeWEidQ986WlxDvmddmYZvU3qvIqzI+CalzWmYBThBZVxASPP0fS3nHXpjYiHfi7RnZ2KVO4dlLN06rAqWt7G8kWLWKNTCADt/GRl+V6kpjGass8YDIYAWAScue3OCNglq8YtazGiRHzqVY296jQLWin/cgTJw1Xp1VIVz/Hfs8hlbParq26dHQ+hY5PUxyp1a+wV6JHg6VlOoKyONclfPFFxeQYSuKZWr551tPBtbMgSXgeytEM8757bCgp4r2cU/4i31pV+mrMO0cac83Bpbk+/3/u9XjTTta3g==
X-Microsoft-Antispam-PRVS: <MWHPR12MB1725AE703525C1C2EC7F294883A90@MWHPR12MB1725.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(198206253151910);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(10201501046)(3002001)(6055026)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR12MB1725;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1725;
X-Forefront-PRVS: 0619D53754
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39380400002)(39860400002)(396003)(366004)(346002)(189003)(199004)(386003)(316002)(446003)(16526019)(106356001)(478600001)(6486002)(72206003)(59450400001)(53936002)(4326008)(1706002)(105586002)(2906002)(2870700001)(68736007)(86362001)(6116002)(8936002)(81166006)(8676002)(81156014)(11346002)(46003)(47776003)(31696002)(64126003)(36756003)(65806001)(65956001)(50466002)(76176011)(2950100002)(52396003)(2486003)(31686004)(52146003)(23676004)(52116002)(6246003)(6666003)(67846002)(25786009)(97736004)(229853002)(7736002)(58126008)(5660300001)(110136005)(65826007)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1725;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyTUIxNzI1OzIzOktjZmMrb2xBQlRtZ0hTUk9NS2ZtNmZDUUx3?=
 =?utf-8?B?ZGtjRCszdWE2QkhVQXBGTklLNVpONzFiWXBSMlM5M1Zhd0Fnb0REYWx3ZTF3?=
 =?utf-8?B?bStCZk1ZMGRsTVhOU1VycHFvRnNxdmVUUHdOc2lUalE2WStZOG5OeWF4d3hJ?=
 =?utf-8?B?akRBTUlTMVNYMDFUUzdmK3pqbG83UEZ4SkVVdDNrOGFBVUx0c3hHOHlHN2tX?=
 =?utf-8?B?WVk5ajgvNmltN3ZRcThEQ0ZJekZmbG52bWdkcWVXd3h2SkFQdDJOQWVuTDFT?=
 =?utf-8?B?SGJRUG9RcHF1Z1NyOUcvZjJKRjc3WnNCYXYxYmM3bVVWRDczU1FuWW8xcmps?=
 =?utf-8?B?NzVKeU9LeTVRaTdiYkVIdURnSlFBbmJYWGducGlYU1dpMlVHRkNyR1pwcXVL?=
 =?utf-8?B?dVZ0Mit1cTFkUXRybGFON2JBaGRQdFBUSUNWN2FSRExYWU5rTCs1RGF3WDBI?=
 =?utf-8?B?c2VyTHNkUkVBcnEvVlNJcDEycS9RSElHWk85VEdYYkJ1MGF4RWVuekQxd01V?=
 =?utf-8?B?Z1FiYkhodElaYURmbUE4OUI3VmZ3N0RFNWMzNi9wbUpobmh3cUlPRkY2dTJZ?=
 =?utf-8?B?SU4vUUlEd1Q4M3V5elFHWUFMYW1zWTRhZVZ3U2pmUmdTZ3cyM1VEendrMFJU?=
 =?utf-8?B?Y2NFM2d3Skk5ckFBbWpXdUFhdDRMWTZGT05mZmNHcEF2d0IzRE9kNy9TSEVW?=
 =?utf-8?B?RTk4RDBYczZGWFhrOHV3MlhlNkQ1c1B5WjJNYk5zaGxJak5uWFpmYkgyeFc4?=
 =?utf-8?B?R2hHNG5kQWhiczFVNzZCa2o4UTNLZk5hMFYrMSs5K0w4RWt5Uk5SeVZubmwr?=
 =?utf-8?B?alk5RDZqOVk2YmIrR3V3SGtucEJwR2Vpc0VyUU9YeCszdmFTRmRTNXVESmRS?=
 =?utf-8?B?Qm9YcW84NHplWGFiWWpkTXZ2UGZZMGEvRnRvVkl5N01iMm14T01TRWkxc1g5?=
 =?utf-8?B?dExqeHFiS2hYbm5DSW9DbU9vUmdISUFFdWxJeHBKZm9wbmNIeFMweGU3cDhS?=
 =?utf-8?B?am1zZWlWWG5ENy8wQVpFOEFmMDZwZWFCbzY3ZWJpYTRQbHAxaDcxcU9acGlP?=
 =?utf-8?B?U2xvNUpzb09KM2hlTnFVUHV0Mm54LzJTanZhUFRCK2k3VXpoTUhXM1gzamd6?=
 =?utf-8?B?eFEyUTUwaFNMSVJpNTB4REFqUGlaOGlTTkF0MHRYR252aitxcjNHb0VaUCtN?=
 =?utf-8?B?aUlMUTNEUU1mR3JtS2FWNjVycEVScXRsR3h2MlRVdmZ2a3UrQkdoWUhQbzN4?=
 =?utf-8?B?T1hxR0FONHg4b0JDVmhJV0d5c3FsUmJJRWJqUnRtTGpoMWxYNnFWQXJKOUpQ?=
 =?utf-8?B?QW00K0pPNUMxS29MeWR0UHRiSy9BamNwaVZYYkV5cFRVSHRHaDJ5WDExU001?=
 =?utf-8?B?TTR1cmI0dWFWTXZVWkdmdGNMMDNZUXNvTTRGNGpLMHA2aDJFa0dvRzJaa21I?=
 =?utf-8?B?VVVEQjA2NkdDMm4yQXVLbThRd2hQclZ5Q09zWkxRbnIrUUtSa2xVRHZQa0N3?=
 =?utf-8?B?NGdmSTJlcjg4bDVEZmxGekRrV0k5Y0hTa3VDOVByWUhVQWZIRGVKZmhhVndZ?=
 =?utf-8?B?d080Q3NJSksrTUlqV2VGMWd2WjFBY2NMNVRXV3UvT3FDY3kzRG5CVTVReHk1?=
 =?utf-8?B?NXZjTzl0am9PMjBIQXZ5d2RVbFJjQ09KUTlGa3JOVkdjWkorSlV0blJiMTRN?=
 =?utf-8?B?ZzMvQU9paE1pVmtCWXZJNmJ0b3V2UlZjckJmOUQxaGsxOHVWSEQzaHAyekZD?=
 =?utf-8?B?OERxRm5QNWV0bGh1bzg0MmIxWGdkS1hWUHRHT1pNMmkwdW9vcGJIRmU0VXVT?=
 =?utf-8?B?WmIxV2hrQlNhbnRjbzMvM1Fsb2RlUzVQNGhCUW8xUjkvcmc9PQ==?=
X-Microsoft-Antispam-Message-Info: jxzQgqRiojB/G8K7MqIOplA+0ZYeqGKuapZ4xVZ/U/iY4zmHhRnctkjmSEQqjfuuVDl6u4shstkZEcQavq4ujXTQvgn3t+flWWUnWsk5bQ3ATE6jLnTY4+u0Kqu9MFQO1JcoyIjJuBfKK9nzjJ23aD74NlaMy0iQWd+uj9Pd5Iyc2hMGoxsoHAy+c3e+hiiy
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1725;6:/+wSPZDyDnLlehQ9m3ZRGAXJw+/YE4ExACgupC3xPp0o9RHzq6PA7laMbAgQ+IGlOKmUNnozcmr8irw3M8qhSmnKc1teEcKmDNUGmm9giBDWLIqw/Q33AIkxUzwaZJt88tp7lbbCBOfQt5B0pi3n/ThcXxYZRgxQ4kYAnIifDlMYTg/Xr4SF+5RJqrJm72eWGMIsWHMZ70426QIv8g5QExnspui2DrnhBKWaRjy7D1ihIDnK2k6fG1iAl67OIjmRFfKZKH0hb1U0ySu+2o3dDzE2LiILOoLW9A4ncovkNqQ8PKCWKiRSBtKhHNCIRTlzfdIuj3gcsL+w9mwRHQOUu6a+GYqi+g+DpuIF0fnCDegG2X/IQTou1kTwRg71981WbCRbyyfNZtyhcUAHfRDx5xzCTeKBx+Nxr6XpYSLOitMWIzuTKWF3TUxoXYfKnmw4H5XLaaddsoWAIUxSudTbCw==;5:P355ueQxUwsnODAyyO4/+Yg18KFGJ1GsgEqs+NzKy+p8ZOKqcd2V4CACXAcZz1yRcQN0rkn752ZyvosGn43sr2xBC/IxaD0nDzKwVd/GkhS2i910ILdJNxvIztk1y1PjE0ydmYmklOndHFzd5ZBHQw6j7/P6de2mBoy9UMS4QOw=;24:rsQEXNk17QBRNEMqYLRKhO3ftPPbFbpVJjRQzLreIZPnqRarD247J6TlC3NgA26GCjnKOmoSOJkFY7H7ZXqn9ui1efIi21OFoixXalbWsC8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1725;7:RgiSYrU15Z12IukSqU1PvSBXZFmGtsJZCoolD08F0569FYwZj3P8v/9F9SII5ln15qfRH+A3cmvhX55XIAwI7tTsqeBWCT4r4rb2Bo3XZMCIto7Y6FBgn1ciS3yrhJPr76NIEod0oHFucsrSxv/WOAOLNX+nQWPh8i2nhLrKUF8v5websXFayqqAZWBv5FCYPwIgrs8VrnvYLRnU3teW36/wKg13k2SuIx+JmYfd19sm2QaN7f/VHRFLWOfoBPsL;20:Pn0/x+d5yXLGzjnZMM3rjWIK8PIMls60A0YXWBjaHqfg4oF7Hv1CfFTrS0KmOAtBlXAsFWN52wn+LNnGlnRDnC6eGRraxN5GIpC0asSOPRBzDuLE+2qtK4yXG/r9SQwjtOxRbM2Jn0KkC99RXWmOc1U/f4+zSDQycg0XKX4fDXoq15QqFFo8Jg6GgWc4HWlKbIrFDh1+S+Pe/JIf1wzqzB7Y9L6dYl7tEDavHiZ5O+iM0m1paxJusetPGerkzgZu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2018 15:43:20.1840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80596678-3978-4d6b-a1a9-08d5900ba48b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1725
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 22.03.2018 um 16:41 schrieb Colin King:
> From: Colin Ian King <colin.king@canonical.com>
>
> Trivial fix to spelling mistake in pr_err error message text
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> index 8fb933c62cf5..493348672475 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> @@ -129,7 +129,7 @@ static void xgpu_ai_mailbox_trans_msg (struct amdgpu_device *adev,
>   		xgpu_ai_mailbox_set_valid(adev, false);
>   		trn = xgpu_ai_peek_ack(adev);
>   		if (trn) {
> -			pr_err("trn=%x ACK should not asssert! wait again !\n", trn);
> +			pr_err("trn=%x ACK should not assert! wait again !\n", trn);
>   			msleep(1);
>   		}
>   	} while(trn);
