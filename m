Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751679AbeD3Jke (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 05:40:34 -0400
Received: from mail-co1nam03on0061.outbound.protection.outlook.com ([104.47.40.61]:38126
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751249AbeD3Jkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 05:40:32 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com;
Subject: Re: [PATCH] ACPI: APD: Add AMD misc clock handler support
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, djkurtz@chromium.org, Alexander.Deucher@amd.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1525072206-17956-1-git-send-email-akshu.agrawal@amd.com>
 <201804301633.FxGiqS4Z%fengguang.wu@intel.com>
From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Message-ID: <096a504f-1d86-afc8-c6db-6ee1073a755c@amd.com>
Date: Mon, 30 Apr 2018 15:10:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <201804301633.FxGiqS4Z%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: PN1PR0101CA0070.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:d::32) To SN1PR12MB2366.namprd12.prod.outlook.com
 (2603:10b6:802:25::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB2366;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2366;3:HiJGmiHiq9d+NIDnHMRP039UhVdG7YBdYmOONM+P5JkBNeNczs3G5ppDtq9t4vgc1pY3l6IuprgtbayIvQ69JXUIPcFqSLHe2WEVPah3zCgR47VV6vwAELAQNkJH8cdVeWLLyt5tzrT29XTHfK4O9+/v47VkmDzOc1SDGEgx3l3Uw6b6yGxcgm2EovhiuCSiy8s2Qv2r7TZj/FOxUaoKEannkIHipTxo4mv8xEEy5a4uKrNKxeKf/sANR5I76BWD;25:bdF92lgrKqjkEgkVqcWx3t99GbRDpoNVeBq1ZxU2rJRvBP3qWvb06Nre59i2+11mWT4+nwnvDWe4TIEK2b460tFCO0MOcCzEbiF8CZdt1zoIvJB4Wylne8/gHmDXPo1yO1LdG/y0RCTZJIy5qsVlzJsif4cdVIrhrlRWikDGkXI1Rq5UQS7MfLyaHZp8cx7SH7A1RcHeH61Se3ZwTii3G9wOTzO3mIXnqBJDNo1sNe9GzBGFYP0rNIet0utRd+sVtGQkPoLmM/YAsPR9eIh7wJB8rPPKoG0o+WZ7dzff5OC47960w8PYI1zcUT3KafNM7ASuePhnJFKrT9t8YRKJIg==;31:1CGUCYib1n8D5rxHYilPupoc/OH15kAEMtjPoB4eUq9wm1XHqEfHSTCPrvFMPN0Ag6oQF/o0tAYplOvOHiNkrDFz/0JLeuwc7XZ6FqO8VtcKZPKxy3pLPAWqSOExnMXGkCvJB6VX75+VY+K7GynhnrP3Q7TtdIkPQ2u8vX+pUSIz0OIWzvsdKmgO/JltYOM/2b6Z33fUbXQAQ11umLBckL0X2wZKYC/qzFRIT3s75Hc=
X-MS-TrafficTypeDiagnostic: SN1PR12MB2366:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2366;20:n1Az/n456bRSDkeKO/zccm1H3yByVHuligzc/XqLNxTnEyCxtmAealvp8TTv80y4rU5vpBCV4Cydz2tkCLOeCd/smlBWkhNN9mx8C/mfLMkKHb1lin8zaeLb0AZ1VZLGb9ZtkZ3RnpDB7Ep4P0yt8NT4w21Q9vawhBuLbSdXQUoCiIU2rblrYQF6Aae+vreWvTBypObhqBKozAsMHjLykY2GMhDiDlIPyDK+og4LDNbn0b4XHRpVccD+hUgoabZRWBlPK5qj0HfJ00O6zflOvTqi40xHFV7kwgOaZuA1XRJSIZVPx7xJj/7PuVFtW5l8GPfLj83gBZyF/H/n0NKjBMlgoT9ZrXNWDvpzyG0loXS1lUM6vx+CIxCOFiA3orS+632uKsruTn/olLYnJYUE9Y8F6FBNikDD7LfKw4y/biG9xz4E0+yWtPeifaGcnloenluzy+ybRR67MTJZI5+n8Hy90R/xqvtPXyIGiPOiZ7sg8H45pKPJ841cnzQx73ks;4:NTASzRcJtsZitVOsRW1DzjSYzKimQ+PkhF/MVbhics5BRB1DcQvWkm19Xl7wZSMFwa/8HMZAnZJHEUtQxxI4dzFdkHT25gFuJLEYIT4JVL0nj7AjpWksGgKDFpDfBxmqgJoaw6RHBN/NS+eXMdOI/ssEBptLSjfNTOnxyq/yPvub7Gz6WbK5tW9mHxV8VUh1j6Ka8Of3mSLs5C/ARxS0cqdneko+OUKn7qoAOK09fSIz7F4g1YEWcp44UjFidxK6TnTwMq/6ebmTRUNLmT6LcpBjhqEr9By0gHU9CfpGyNt+us4i+33CA7g/g9BnCgcv5cNLeH6DZR9rBexo+u9zYGktJx/pp6Ka6l/8HqsVBCZcZVslGht2LBovYwjtcjgU
X-Microsoft-Antispam-PRVS: <SN1PR12MB23661BF1627577BA0588D9D3F8820@SN1PR12MB2366.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820)(162533806227266)(84791874153150);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:SN1PR12MB2366;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB2366;
X-Forefront-PRVS: 0658BAF71F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(396003)(346002)(39380400002)(376002)(39860400002)(199004)(189003)(4326008)(966005)(68736007)(2906002)(6306002)(65826007)(97736004)(486006)(72206003)(345774005)(478600001)(25786009)(3260700006)(305945005)(476003)(2616005)(956004)(5890100001)(11346002)(446003)(50466002)(64126003)(230700001)(36756003)(3846002)(6486002)(31696002)(6116002)(86362001)(6666003)(229853002)(6916009)(105586002)(54906003)(52116002)(106356001)(26005)(77096007)(58126008)(47776003)(65956001)(65806001)(66066001)(316002)(67846002)(81166006)(8676002)(81156014)(8936002)(16576012)(5660300001)(23746002)(6246003)(7736002)(186003)(76176011)(53546011)(386003)(31686004)(53936002)(16526019);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB2366;H:[10.136.128.133];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;SN1PR12MB2366;23:j4J065UgsRIPDo+EL+sqYWt2SSWlFEvmvSjZm?=
 =?Windows-1252?Q?2HGyCbMCvtfmxukA+IZbaSVue8ARCxD5dipwJ18dQbLVldwDjcdPxhK8?=
 =?Windows-1252?Q?yUsqpUl/5LzL3RbyqOIMo1YEQZM5yruR4wE/cesVBYjDnotMlYg3VOML?=
 =?Windows-1252?Q?9kuW5fn1ROMoYrnoxPaq0sv9sAWE6eX5MAfjXdP4K5XFQkMUdlf/IjGm?=
 =?Windows-1252?Q?4KrdUxGrmUlALWXOh/CCrHWBFVSNgljYz16+UQW5TbWCLvgQtkBS+rLQ?=
 =?Windows-1252?Q?65Jj0rfyJaomm8qxH4l65oPfSf+jFX8uwN9K4eRLnfHJqwXxbZCt3MWw?=
 =?Windows-1252?Q?GYqRvLlxXPlKrqyVjiRV1MyLeh3aS570VzST5O/XFyywFEsitdXAwZB/?=
 =?Windows-1252?Q?0/6di5xuG9xCjUPhRFr6J7bgFOpAPd44uv4z2tBpBpr/4a/yo/SKXC5+?=
 =?Windows-1252?Q?erD39bXcGfJH2WNB2Y3FqgtxYfwSAu57MyLiDrEnGESbhnJ7tP78uNZp?=
 =?Windows-1252?Q?evY4HXYhoCv5V5+zhVN5t/gwX1/xf7XlAYt3e9CIFu+BWRXgHU9KwO7W?=
 =?Windows-1252?Q?lWjd8qwcqQeZo1kpcKgCvj8NatikmHJehuVvPe0OLSdeIUjmiH1Wp49I?=
 =?Windows-1252?Q?MPiObcAVh/BBVOJ4XFVWMl+LmbDq+vF/oZHh36UKT7FrG8SvkzBLjxBH?=
 =?Windows-1252?Q?ZCCwsbq+3x1MA51v8GbRkVWfJ24L/tbByeSyuOcvIVQvR+ON4HSG3+gA?=
 =?Windows-1252?Q?kmEnyJcLW1r5MtkF/K9ztm1zIo1AAg20B7/FK8UCoTTohRXvhVzi5uM9?=
 =?Windows-1252?Q?0ettX5+a3siq0u9J9z5PSNx10UNBZW+g14g3ZJUlXn5BIePRN0Z3bvh6?=
 =?Windows-1252?Q?jqrqBcFqFjzYZ0q+1at0GN5XSTvUkj5YMCV2VavNYsBVMvam6UbMu+tl?=
 =?Windows-1252?Q?8mAQ9jSLjdJGLFYCqqAC23hkne3HS/Um0a0o0oQDNPvyMaIYHFeMNc6G?=
 =?Windows-1252?Q?l8iGgs8np2n++Kh/1HrUSfZ6fCevY8E5KXBpNMTBdRpx5AQm2k3lZinc?=
 =?Windows-1252?Q?lt/CAWv4r7tSOFy2AXPVWVbf82OdMVLruFLc1nnD8WnzdiHUDJn83Gmz?=
 =?Windows-1252?Q?fnmdN3I6Bep1TF0MXzDmDCRz1IollA09qUEsvQscXyFOKN8nEtd0fHc9?=
 =?Windows-1252?Q?RtOIsEgtegXfaPgjB6m3aUnv+HClwC+KTwgDMovjWNRvz6hFgKqsjuA9?=
 =?Windows-1252?Q?4Fij6o2Du/4Qd4AiT0BB928AmPuX3L0n+v3vuCKq//Dc1AfdaufrjPly?=
 =?Windows-1252?Q?tudFVbCmJvJy84Ma3B5e4YCLBVYR/nsorfEMmYc0H0qFLTMX5pFdWKXl?=
 =?Windows-1252?Q?EQ0zQw5YcoJjaSYQ/VgDbrtecjcmNEGV1k8WEvMHgBdbZpgsvNPqu4tJ?=
 =?Windows-1252?Q?QKhwFdKarEC+2trVF0q8N6Ka7D0DBImjgXotC/jwKlhKxITiyR1S7IUr?=
 =?Windows-1252?Q?duw0YYJcapuGLCgQ6NsKW9S17/QAQ2CP8o3lTnC4q+dqGWCTwcBHzTSk?=
 =?Windows-1252?Q?GcYJVYSZCsekIQSfL3qoxB/UCSCc8i8JfOfbr+DhA3bkQNiOd3wTFtgc?=
 =?Windows-1252?Q?3aqIOrPq+AVXqZQXAo6s5BIJaUq5+IRhA+PKTL0VtAYtQiKOhqWczwsl?=
 =?Windows-1252?Q?iSimzQWDQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: xn7httGvDf2SOPKBZoYEH5SLNmB5pWSHu8ugoDuKJQ0f8b4MSCn77G2ixN6/4XGKqLz0/bobSjWPjfTZ2zJ6YHBBnk5KWyB4lQxZG9AKajLW5RtxB7ErmU7PSo1gfqOI9zKWr707BkGZPIpIaQZEy1Ex0QhMkV6MnOsxp9Vmvc7nwXJdxYfY/ufP+E/PTbtL
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2366;6:NIWgEvpntZQm7Zo1Ld2yKRo9hZvSGzV1gdMe2Cdd17IosBBGcw6suwXfap7Ph6Z2bv3E9QEpWNh+QAN3fEnfGyDZmX+Hyuvy643aHe231Qh6Pm+bCiZK9sW+wqal0l45gLnqLyW9gaLK3qzEmxBNx8lt2I/3ye6SmDYpRsqKp3DguXVOULXsX7azKqt2MfLtjGgjFvaZEfxURsRs0EC1wYgkXji4DTGuh8v/vFXMPctHf5Wo4hOXkhW44cT6TeFhrD456ypI2Q7+EJiwcMm29ZVvJgHZNQ0Q4OF2YiAhed+tqrGzBPJFN9ovGg2Kdb5Q+Uaab+4AJj8XFi5hqODbK0mz2gUyDFSmmpnPGpL5mkyWd73T0ZmxOA5jaNogn7b9s8UTYmpOwtXvMxAVSmvdUbX1LQq99lV1cp4KQcV4+xyGOzT+6qXgtVj4Fayfx6/wHZbByfUzM4LQhg/G+FpbTw==;5:09N6AeIIvJVgrVODPaNYyig8dZ6lqa1zSuvuNgFZPPb/dAA9ly6UDPme91btbsH1VZOmp4YsVUbir0PQI9bLstbHuL1kADdtVwzRK0Ay9+eCi9ac6PBn1VfVhongWqELGj0MMBYItsa7nIPJ+q5LPNfK0XZOWYQGF/zWYVGREsA=;24:Aue7sr9s9kN43m59J5+/QRdYgRhj/toUIYNo8/hNccYxNom2qM9f4COZU2OxLEKzRMt5QDNs0bReVyOA48TRhbxq54jSvWKgBvcL0MJ1OqI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2366;7:ulI5k67gBJwu9vC7KfCYdlSIhFhe72jge1e6qLKWaK6beCYaNPFip/c6l4Dfwq4JWGbdo3VTrjclGf7X3a2CY2OuaQpZx+zG5VFny2FZdEC1R4gNkYr0NCTRXLRFChQxlWcyA2+8u6AgH1BZbESH5WgJMJaqe0tlBj/ZC6SPQQiJZARmyhTdVWZNJLhex1anbtVI4nbgDimqoqfPcEwHrEURffWgfEVHL0ZY6fu5GRpWziz384hnNchGFr2cX5ZH;20:VLovlR+UISFOonG/VAWNqrSpP7a8B/e23t4t9tKl3+IUiCM+seTPJZmiZDWKnlJmqWveBnugpbqdHinBxYqO5vxBqhO0y0i0jF0W9vfaOlCVzQHQCcDsXRV2rEOOSdoUs7OJade2F0PV+nj+AsFvscbS2C/aYeZ782GnzAMJWyRFLwaJUaEhGLDM4pqV1Bn0Q8qnj0OwS9Pzcdxdz7A2uDFismJq41AxIJBpJ5s1HKU/QJoUgvQ/KDZx3KjHHIiS
X-MS-Office365-Filtering-Correlation-Id: 9a8e1f58-538a-4297-b7c7-08d5ae7e6944
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2018 09:40:26.8075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a8e1f58-538a-4297-b7c7-08d5ae7e6944
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2366
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/30/2018 2:23 PM, kbuild test robot wrote:
> Hi Akshu,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on pm/linux-next]
> [also build test ERROR on v4.17-rc3 next-20180426]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Akshu-Agrawal/ACPI-APD-Add-AMD-misc-clock-handler-support/20180430-152810
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
> config: x86_64-acpi-redef (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> reproduce:
>          # save the attached .config to linux build tree
>          make ARCH=x86_64
> 
> All errors (new ones prefixed by >>):
> 
>>> drivers//acpi/acpi_apd.c:14:10: fatal error: linux/platform_data/clk-st.h: No such file or directory
>      #include <linux/platform_data/clk-st.h>
>               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     compilation terminated.
> 

This patch is dependent on https://patchwork.kernel.org/patch/10370955/
The above patch adds the required include file.

Thanks,
Akshu
> vim +14 drivers//acpi/acpi_apd.c
> 
>    > 14	#include <linux/platform_data/clk-st.h>
>      15	#include <linux/platform_device.h>
>      16	#include <linux/pm_domain.h>
>      17	#include <linux/clkdev.h>
>      18	#include <linux/acpi.h>
>      19	#include <linux/err.h>
>      20	#include <linux/pm.h>
>      21	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
